import { createClient } from '@supabase/supabase-js';
import { Database } from '@/types/supabase';
import { 
  Lesson, 
  Quiz, 
  Challenge, 
  UserProfile, 
  Badge, 
  UserBadge, 
  LessonProgress 
} from '@/types/supabase';

// Initialize Supabase client
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || '';
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || '';

export const supabase = createClient<Database>(supabaseUrl, supabaseAnonKey);

// Lesson functions
export async function getLessons({ 
  limit = 10, 
  orderBy = 'order_index', 
  ascending = true
}: { 
  limit?: number, 
  orderBy?: string, 
  ascending?: boolean 
} = {}): Promise<Lesson[]> {
  const { data, error } = await supabase
    .from('lessons')
    .select('*')
    .order(orderBy, { ascending })
    .limit(limit);

  if (error) {
    console.error('Error fetching lessons:', error);
    throw error;
  }

  return data || [];
}

export async function getLesson(id: string): Promise<Lesson | null> {
  const { data, error } = await supabase
    .from('lessons')
    .select(`
      *,
      quizzes (*),
      challenges (*)
    `)
    .eq('id', id)
    .single();

  if (error) {
    console.error(`Error fetching lesson with ID ${id}:`, error);
    return null;
  }

  return data as Lesson;
}

export async function getNextLesson(currentLessonId: string): Promise<Lesson | null> {
  // First, get the current lesson to find the next_lesson_id
  const { data: currentLesson, error: currentError } = await supabase
    .from('lessons')
    .select('next_lesson_id')
    .eq('id', currentLessonId)
    .single();

  if (currentError || !currentLesson?.next_lesson_id) {
    return null;
  }

  // Then, get the next lesson
  const { data: nextLesson, error: nextError } = await supabase
    .from('lessons')
    .select('*')
    .eq('id', currentLesson.next_lesson_id)
    .single();

  if (nextError) {
    return null;
  }

  return nextLesson as Lesson;
}

// User Profile functions
export async function createUserProfile(userId: string, username?: string): Promise<UserProfile | null> {
  const { data, error } = await supabase
    .from('user_profiles')
    .insert([{ 
      user_id: userId, 
      username: username || null,
      points: 0,
      streak: 0,
      streak_last_updated: new Date().toISOString()
    }])
    .select()
    .single();

  if (error) {
    console.error('Error creating user profile:', error);
    return null;
  }

  return data as UserProfile;
}

export async function getUserProfile(userId: string): Promise<UserProfile | null> {
  const { data, error } = await supabase
    .from('user_profiles')
    .select('*')
    .eq('user_id', userId)
    .single();

  if (error) {
    console.error(`Error fetching profile for user ${userId}:`, error);
    return null;
  }

  return data as UserProfile;
}

export async function updateUserProfile(userId: string, updates: Partial<UserProfile>): Promise<UserProfile | null> {
  const { data, error } = await supabase
    .from('user_profiles')
    .update(updates)
    .eq('user_id', userId)
    .select()
    .single();

  if (error) {
    console.error(`Error updating profile for user ${userId}:`, error);
    return null;
  }

  return data as UserProfile;
}

// Subscription functions
export async function getUserSubscription(userId: string): Promise<any | null> {
  const { data, error } = await supabase
    .from('user_subscriptions')
    .select(`
      *,
      plan:plan_id (*)
    `)
    .eq('user_id', userId)
    .maybeSingle();

  if (error) {
    console.error(`Error fetching subscription for user ${userId}:`, error);
    return null;
  }

  return data;
}

// Badges functions
export async function getUserBadges(userId: string): Promise<UserBadge[]> {
  const { data, error } = await supabase
    .from('user_badges')
    .select(`
      *,
      badge:badge_id (*)
    `)
    .eq('user_id', userId);

  if (error) {
    console.error(`Error fetching badges for user ${userId}:`, error);
    return [];
  }

  return data as UserBadge[];
}

export async function awardBadge(userId: string, badgeId: string): Promise<UserBadge | null> {
  const { data, error } = await supabase
    .from('user_badges')
    .insert([{ 
      user_id: userId, 
      badge_id: badgeId,
      earned_at: new Date().toISOString()
    }])
    .select()
    .single();

  if (error) {
    console.error(`Error awarding badge ${badgeId} to user ${userId}:`, error);
    return null;
  }

  return data as UserBadge;
}

// Lesson progress functions
export async function getUserLessonProgress(userId: string): Promise<LessonProgress[]> {
  const { data, error } = await supabase
    .from('lesson_progress')
    .select('*')
    .eq('user_id', userId);

  if (error) {
    console.error(`Error fetching lesson progress for user ${userId}:`, error);
    return [];
  }

  return data as LessonProgress[];
}

export async function startLesson(userId: string, lessonId: string): Promise<boolean> {
  try {
    // Check if user has already started this lesson
    const { data: existingProgress, error: fetchError } = await supabase
      .from('user_lesson_progress')
      .select('*')
      .eq('user_id', userId)
      .eq('lesson_id', lessonId)
      .single();
      
    if (fetchError && fetchError.code !== 'PGRST116') { // PGRST116 means no rows returned
      console.error(`Error checking existing progress for lesson ${lessonId}:`, fetchError);
      return false;
    }
    
    const now = new Date().toISOString();
    
    if (existingProgress) {
      // Update existing progress entry if not completed
      if (!existingProgress.completed_at) {
        const { error: updateError } = await supabase
          .from('user_lesson_progress')
          .update({ 
            last_accessed_at: now,
            updated_at: now
          })
          .eq('id', existingProgress.id);
          
        if (updateError) {
          console.error(`Error updating lesson progress for ${lessonId}:`, updateError);
          return false;
        }
      }
    } else {
      // Create new progress entry
      const { error: insertError } = await supabase
        .from('user_lesson_progress')
        .insert({
          user_id: userId,
          lesson_id: lessonId,
          started_at: now,
          last_accessed_at: now,
          status: 'in_progress',
          created_at: now,
          updated_at: now
        });
        
      if (insertError) {
        console.error(`Error creating lesson progress for ${lessonId}:`, insertError);
        return false;
      }
    }
    
    // Update user's last activity date for streak calculation
    await updateUserStreak(userId);
    
    return true;
  } catch (error) {
    console.error(`Unexpected error in startLesson for ${lessonId}:`, error);
    return false;
  }
}

export async function completeLesson(
  userId: string, 
  lessonId: string, 
  quizScore: number | null = 1, 
  challengeCompleted: boolean = false
): Promise<boolean> {
  try {
    // Get lesson data to calculate points
    const { data: lessonData, error: lessonError } = await supabase
      .from('lessons')
      .select('points, xp_reward')
      .eq('id', lessonId)
      .single();
      
    if (lessonError) {
      console.error(`Error fetching lesson ${lessonId} data:`, lessonError);
      return false;
    }
    
    const now = new Date().toISOString();
    const earnedPoints = Math.round((lessonData.points || 0) * (quizScore || 1));
    const earnedXP = lessonData.xp_reward || 0;
    
    // Update or create lesson progress record
    const { data: existingProgress, error: fetchError } = await supabase
      .from('user_lesson_progress')
      .select('id, completed_at')
      .eq('user_id', userId)
      .eq('lesson_id', lessonId)
      .single();
      
    let progressId;
    
    if (fetchError && fetchError.code !== 'PGRST116') {
      console.error(`Error checking existing progress for lesson ${lessonId}:`, fetchError);
      return false;
    }
    
    if (existingProgress) {
      // Skip if already completed
      if (existingProgress.completed_at) {
        return true;
      }
      
      // Update existing record
      const { error: updateError } = await supabase
        .from('user_lesson_progress')
        .update({ 
          completed_at: now,
          quiz_score: quizScore,
          challenge_completed: challengeCompleted,
          earned_points: earnedPoints,
          earned_xp: earnedXP,
          status: 'completed',
          updated_at: now
        })
        .eq('id', existingProgress.id);
        
      if (updateError) {
        console.error(`Error updating lesson progress for ${lessonId}:`, updateError);
        return false;
      }
      
      progressId = existingProgress.id;
    } else {
      // Create new completed progress entry
      const { data: newProgress, error: insertError } = await supabase
        .from('user_lesson_progress')
        .insert({
          user_id: userId,
          lesson_id: lessonId,
          started_at: now,
          last_accessed_at: now,
          completed_at: now,
          quiz_score: quizScore,
          challenge_completed: challengeCompleted,
          earned_points: earnedPoints,
          earned_xp: earnedXP,
          status: 'completed',
          created_at: now,
          updated_at: now
        })
        .select('id');
        
      if (insertError || !newProgress) {
        console.error(`Error creating lesson progress for ${lessonId}:`, insertError);
        return false;
      }
      
      progressId = newProgress[0].id;
    }
    
    // Add points to user's profile
    await addPointsToUser(userId, earnedPoints + earnedXP);
    
    // Update user's streak
    await updateUserStreak(userId);
    
    return true;
  } catch (error) {
    console.error(`Unexpected error in completeLesson for ${lessonId}:`, error);
    return false;
  }
}

export async function updateLessonProgress(
  userId: string, 
  lessonId: string, 
  progress: Partial<LessonProgress>
): Promise<LessonProgress | null> {
  // First, check if a progress record already exists
  const { data: existingData, error: existingError } = await supabase
    .from('lesson_progress')
    .select('*')
    .eq('user_id', userId)
    .eq('lesson_id', lessonId)
    .maybeSingle();
  
  if (existingError) {
    console.error(`Error checking existing progress for lesson ${lessonId} and user ${userId}:`, existingError);
    return null;
  }
  
  // If progress exists, update it
  if (existingData) {
    const { data: updatedData, error: updateError } = await supabase
      .from('lesson_progress')
      .update({
        ...progress,
        updated_at: new Date().toISOString()
      })
      .eq('id', existingData.id)
      .select()
      .single();
      
    if (updateError) {
      console.error(`Error updating progress for lesson ${lessonId} and user ${userId}:`, updateError);
      return null;
    }
    
    return updatedData as LessonProgress;
  }
  
  // Otherwise, create a new progress record
  const { data: newData, error: insertError } = await supabase
    .from('lesson_progress')
    .insert([{
      user_id: userId,
      lesson_id: lessonId,
      started_at: new Date().toISOString(),
      ...progress
    }])
    .select()
    .single();
    
  if (insertError) {
    console.error(`Error creating progress for lesson ${lessonId} and user ${userId}:`, insertError);
    return null;
  }
  
  return newData as LessonProgress;
}

export async function markLessonCompleted(
  userId: string, 
  lessonId: string, 
  quizScore?: number
): Promise<LessonProgress | null> {
  // Update or create progress record
  return await updateLessonProgress(userId, lessonId, {
    completed: true,
    completed_at: new Date().toISOString(),
    quiz_score: quizScore
  });
}

// Points and rewards
export async function addPointsToUser(userId: string, points: number): Promise<UserProfile | null> {
  const { data, error } = await supabase.rpc('increment_user_points', {
    user_id: userId,
    points_to_add: points
  });
  
  if (error) {
    console.error(`Error adding ${points} points to user ${userId}:`, error);
    return null;
  }
  
  // Get updated user profile
  return await getUserProfile(userId);
}

// Function to update user streak (should be called daily)
export async function updateUserStreak(userId: string): Promise<UserProfile | null> {
  // Get current user profile
  const profile = await getUserProfile(userId);
  if (!profile) return null;
  
  const lastUpdated = new Date(profile.streak_last_updated);
  const now = new Date();
  
  // Calculate the difference in days
  const diffTime = Math.abs(now.getTime() - lastUpdated.getTime());
  const diffDays = Math.floor(diffTime / (1000 * 60 * 60 * 24));
  
  let newStreak = profile.streak;
  
  // If it's been exactly 1 day since last update, increment streak
  if (diffDays === 1) {
    newStreak += 1;
  } 
  // If it's been more than 1 day, reset streak to 1
  else if (diffDays > 1) {
    newStreak = 1;
  }
  // If it's the same day, keep the streak as is
  
  // Update the streak
  return await updateUserProfile(userId, {
    streak: newStreak,
    streak_last_updated: now.toISOString()
  });
}

// Helper functions for user points and streak management

/**
 * Add points to a user's profile
 */
export async function addPointsToUser(userId: string, points: number): Promise<boolean> {
  if (!points) return true; // Skip if no points to add
  
  // Get current user data first
  const { data: userData, error: fetchError } = await supabase
    .from('profiles')
    .select('points')
    .eq('id', userId)
    .single();
    
  if (fetchError) {
    console.error(`Error fetching user ${userId} data:`, fetchError);
    return false;
  }
  
  // Calculate new points total
  const currentPoints = userData?.points || 0;
  const newTotal = currentPoints + points;
  
  // Update the points in the profile
  const { error: updateError } = await supabase
    .from('profiles')
    .update({ 
      points: newTotal,
      updated_at: new Date().toISOString() 
    })
    .eq('id', userId);
    
  if (updateError) {
    console.error(`Error updating points for user ${userId}:`, updateError);
    return false;
  }
  
  return true;
}

/**
 * Update user's learning streak
 */
export async function updateUserStreak(userId: string): Promise<boolean> {
  // Get current user streak data
  const { data: userData, error: fetchError } = await supabase
    .from('profiles')
    .select('streak, last_activity_date')
    .eq('id', userId)
    .single();
    
  if (fetchError) {
    console.error(`Error fetching streak data for user ${userId}:`, fetchError);
    return false;
  }
  
  const today = new Date().toISOString().split('T')[0]; // YYYY-MM-DD format
  const lastActivity = userData?.last_activity_date 
    ? userData.last_activity_date.split('T')[0]
    : null;
    
  let newStreak = userData?.streak || 0;
  
  // Calculate if we should increment streak
  if (!lastActivity) {
    // First activity
    newStreak = 1;
  } else if (lastActivity === today) {
    // Already counted for today, no change
  } else {
    // Check if yesterday or continuous streak
    const yesterday = new Date();
    yesterday.setDate(yesterday.getDate() - 1);
    const yesterdayStr = yesterday.toISOString().split('T')[0];
    
    if (lastActivity === yesterdayStr) {
      // Continuous streak
      newStreak += 1;
    } else {
      // Streak broken, start new
      newStreak = 1;
    }
  }
  
  // Update the streak in the profile
  const { error: updateError } = await supabase
    .from('profiles')
    .update({ 
      streak: newStreak,
      last_activity_date: new Date().toISOString(),
      updated_at: new Date().toISOString() 
    })
    .eq('id', userId);
    
  if (updateError) {
    console.error(`Error updating streak for user ${userId}:`, updateError);
    return false;
  }
  
  return true;
}

// Export common types from Supabase
export type { 
  Lesson, 
  Quiz, 
  Challenge, 
  UserProfile, 
  Badge, 
  UserBadge, 
  LessonProgress 
};