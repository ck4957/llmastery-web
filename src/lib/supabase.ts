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