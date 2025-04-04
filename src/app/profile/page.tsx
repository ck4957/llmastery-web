'use client';

import { useState, useEffect } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { useAuth } from '@/lib/auth-context';
import { 
  getUserProfile, 
  getUserSubscription,
  updateUserProfile,
  type UserProfile,
  type UserSubscription
} from '@/lib/supabase';

const ProfilePage = () => {
  const router = useRouter();
  const { user, signOut, loading: authLoading } = useAuth();
  
  const [userProfile, setUserProfile] = useState<UserProfile | null>(null);
  const [subscription, setSubscription] = useState<UserSubscription | null>(null);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [isEditing, setIsEditing] = useState(false);
  const [formData, setFormData] = useState({
    username: '',
    fullName: '',
    bio: '',
    email: '',
  });
  const [message, setMessage] = useState({ type: '', text: '' });

  // Check if user is logged in, redirect to login if not
  useEffect(() => {
    if (!authLoading && !user) {
      router.push('/login');
    }
  }, [user, authLoading, router]);

  // Fetch user data when authenticated
  useEffect(() => {
    const fetchData = async () => {
      if (!user) return;

      try {
        setLoading(true);
        
        // Get all data in parallel for better performance
        const [profileData, subscriptionData] = await Promise.all([
          getUserProfile(user.id),
          getUserSubscription(user.id)
        ]);
        
        setUserProfile(profileData);
        setSubscription(subscriptionData);
        
        // Initialize form data
        if (profileData) {
          setFormData({
            username: profileData.username || '',
            fullName: profileData.full_name || '',
            bio: profileData.bio || '',
            email: user.email || '',
          });
        }
      } catch (error) {
        console.error('Error fetching profile data:', error);
      } finally {
        setLoading(false);
      }
    };

    if (user) {
      fetchData();
    }
  }, [user]);

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!user) return;
    
    try {
      setSaving(true);
      await updateUserProfile(user.id, {
        username: formData.username,
        full_name: formData.fullName,
        bio: formData.bio,
      });
      
      setMessage({ type: 'success', text: 'Profile updated successfully!' });
      setIsEditing(false);
      
      // Refresh profile data
      const updatedProfile = await getUserProfile(user.id);
      setUserProfile(updatedProfile);
    } catch (error) {
      console.error('Error updating profile:', error);
      setMessage({ type: 'error', text: 'Failed to update profile. Please try again.' });
    } finally {
      setSaving(false);
      
      // Clear message after 3 seconds
      setTimeout(() => {
        setMessage({ type: '', text: '' });
      }, 3000);
    }
  };

  const formatDate = (dateString: string) => {
    const date = new Date(dateString);
    return new Intl.DateTimeFormat('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    }).format(date);
  };

  const getPlanDetails = () => {
    if (!subscription) return { name: 'Free Plan', description: 'Basic access to lessons', color: 'gray' };
    
    switch(subscription.plan_id) {
      case 'basic':
        return { 
          name: 'Basic Plan', 
          description: 'Access to fundamental lessons and basic community features',
          color: 'blue' 
        };
      case 'pro':
        return { 
          name: 'Pro Plan', 
          description: 'Full access to all lessons and priority community support',
          color: 'indigo' 
        };
      case 'premium':
        return { 
          name: 'Premium Plan', 
          description: 'Everything in Pro plus 1-on-1 mentoring sessions',
          color: 'purple' 
        };
      default:
        return { 
          name: subscription.plan_id || 'Unknown Plan', 
          description: 'Subscription active',
          color: 'gray' 
        };
    }
  };

  const planDetails = getPlanDetails();
  
  if (authLoading || loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-indigo-500"></div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      {/* Header/Navigation */}
      <header className="bg-white dark:bg-gray-800 shadow-sm">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4 flex justify-between items-center">
          <div className="flex items-center">
            <Link href="/" className="text-2xl font-bold text-indigo-600 dark:text-indigo-400">LLMastery</Link>
          </div>
          <nav className="hidden md:flex items-center space-x-8">
            <Link href="/dashboard" className="text-gray-600 dark:text-gray-300 hover:text-indigo-600 dark:hover:text-indigo-400">
              Dashboard
            </Link>
            <Link href="/community" className="text-gray-600 dark:text-gray-300 hover:text-indigo-600 dark:hover:text-indigo-400">
              Community
            </Link>
            <Link href="/pricing" className="text-gray-600 dark:text-gray-300 hover:text-indigo-600 dark:hover:text-indigo-400">
              Pricing
            </Link>
            <Link href="/profile" className="text-gray-900 dark:text-white font-medium hover:text-indigo-600 dark:hover:text-indigo-400">
              Profile
            </Link>
          </nav>
          <div className="flex items-center space-x-4">
            <button 
              onClick={() => signOut()}
              className="text-gray-500 hover:text-gray-700 dark:text-gray-300 dark:hover:text-white"
            >
              Sign Out
            </button>
          </div>
        </div>
      </header>

      <main className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="bg-white dark:bg-gray-800 rounded-xl shadow-sm overflow-hidden">
          <div className="p-6">
            <h1 className="text-2xl font-bold text-gray-900 dark:text-white mb-6">
              User Profile
            </h1>
            
            {/* Success or Error Message */}
            {message.text && (
              <div className={`mb-6 p-4 rounded-md ${
                message.type === 'success' ? 'bg-green-50 dark:bg-green-900/20 text-green-800 dark:text-green-200' : 
                'bg-red-50 dark:bg-red-900/20 text-red-800 dark:text-red-200'
              }`}>
                {message.text}
              </div>
            )}

            <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
              {/* Left Column - User Profile Form */}
              <div className="md:col-span-2">
                {isEditing ? (
                  <form onSubmit={handleSubmit} className="space-y-6">
                    <div>
                      <label htmlFor="email" className="block text-sm font-medium text-gray-700 dark:text-gray-300">
                        Email
                      </label>
                      <input
                        type="email"
                        name="email"
                        id="email"
                        value={formData.email}
                        disabled
                        className="mt-1 block w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm 
                                  bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300"
                      />
                      <p className="mt-1 text-xs text-gray-500 dark:text-gray-400">
                        Contact support to change your email address
                      </p>
                    </div>
                    <div>
                      <label htmlFor="username" className="block text-sm font-medium text-gray-700 dark:text-gray-300">
                        Username
                      </label>
                      <input
                        type="text"
                        name="username"
                        id="username"
                        value={formData.username}
                        onChange={handleInputChange}
                        className="mt-1 block w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm 
                                  focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 dark:focus:ring-indigo-400 dark:focus:border-indigo-400 
                                  bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-200"
                      />
                    </div>
                    <div>
                      <label htmlFor="fullName" className="block text-sm font-medium text-gray-700 dark:text-gray-300">
                        Full Name
                      </label>
                      <input
                        type="text"
                        name="fullName"
                        id="fullName"
                        value={formData.fullName}
                        onChange={handleInputChange}
                        className="mt-1 block w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm 
                                  focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 dark:focus:ring-indigo-400 dark:focus:border-indigo-400 
                                  bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-200"
                      />
                    </div>
                    <div>
                      <label htmlFor="bio" className="block text-sm font-medium text-gray-700 dark:text-gray-300">
                        Bio
                      </label>
                      <textarea
                        name="bio"
                        id="bio"
                        rows={4}
                        value={formData.bio}
                        onChange={handleInputChange}
                        className="mt-1 block w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm 
                                  focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 dark:focus:ring-indigo-400 dark:focus:border-indigo-400 
                                  bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-200"
                      />
                    </div>
                    <div className="flex justify-end space-x-3">
                      <button
                        type="button"
                        onClick={() => setIsEditing(false)}
                        className="px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-md text-sm font-medium 
                                  text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700"
                      >
                        Cancel
                      </button>
                      <button
                        type="submit"
                        disabled={saving}
                        className="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium 
                                  text-white bg-indigo-600 hover:bg-indigo-700 dark:bg-indigo-500 dark:hover:bg-indigo-600
                                  focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 dark:focus:ring-offset-gray-800"
                      >
                        {saving ? 'Saving...' : 'Save Changes'}
                      </button>
                    </div>
                  </form>
                ) : (
                  <div className="space-y-6">
                    <div>
                      <h3 className="text-sm font-medium text-gray-500 dark:text-gray-400">Email</h3>
                      <p className="mt-1 text-md text-gray-900 dark:text-white">{user?.email}</p>
                    </div>
                    <div>
                      <h3 className="text-sm font-medium text-gray-500 dark:text-gray-400">Username</h3>
                      <p className="mt-1 text-md text-gray-900 dark:text-white">
                        {userProfile?.username || 'Not set'}
                      </p>
                    </div>
                    <div>
                      <h3 className="text-sm font-medium text-gray-500 dark:text-gray-400">Full Name</h3>
                      <p className="mt-1 text-md text-gray-900 dark:text-white">
                        {userProfile?.full_name || 'Not set'}
                      </p>
                    </div>
                    <div>
                      <h3 className="text-sm font-medium text-gray-500 dark:text-gray-400">Bio</h3>
                      <p className="mt-1 text-md text-gray-900 dark:text-white whitespace-pre-line">
                        {userProfile?.bio || 'No bio provided'}
                      </p>
                    </div>
                    <div>
                      <h3 className="text-sm font-medium text-gray-500 dark:text-gray-400">Member Since</h3>
                      <p className="mt-1 text-md text-gray-900 dark:text-white">
                        {userProfile?.created_at ? formatDate(userProfile.created_at) : 'Unknown'}
                      </p>
                    </div>
                    <div>
                      <button
                        type="button"
                        onClick={() => setIsEditing(true)}
                        className="px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-md text-sm font-medium 
                                   text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700"
                      >
                        Edit Profile
                      </button>
                    </div>
                  </div>
                )}
              </div>

              {/* Right Column - Subscription Info */}
              <div>
                <div className="bg-gray-50 dark:bg-gray-700 p-6 rounded-lg">
                  <h3 className="font-semibold text-lg text-gray-900 dark:text-white mb-4">
                    Subscription
                  </h3>

                  <div className={`mb-6 p-4 rounded-lg border ${
                    planDetails.color === 'purple' ? 'bg-purple-50 dark:bg-purple-900/20 border-purple-200 dark:border-purple-800' : 
                    planDetails.color === 'indigo' ? 'bg-indigo-50 dark:bg-indigo-900/20 border-indigo-200 dark:border-indigo-800' : 
                    planDetails.color === 'blue' ? 'bg-blue-50 dark:bg-blue-900/20 border-blue-200 dark:border-blue-800' : 
                    'bg-gray-100 dark:bg-gray-800 border-gray-200 dark:border-gray-700'
                  }`}>
                    <h4 className={`font-bold ${
                      planDetails.color === 'purple' ? 'text-purple-700 dark:text-purple-300' : 
                      planDetails.color === 'indigo' ? 'text-indigo-700 dark:text-indigo-300' : 
                      planDetails.color === 'blue' ? 'text-blue-700 dark:text-blue-300' : 
                      'text-gray-700 dark:text-gray-300'
                    }`}>
                      {planDetails.name}
                    </h4>
                    <p className="text-gray-600 dark:text-gray-400 text-sm mt-1">
                      {planDetails.description}
                    </p>
                  </div>

                  {subscription && (
                    <div className="space-y-3 text-sm">
                      <div className="flex justify-between">
                        <span className="text-gray-600 dark:text-gray-400">Status:</span>
                        <span className={`font-medium ${
                          subscription.status === 'active' ? 'text-green-600 dark:text-green-400' : 
                          subscription.status === 'trialing' ? 'text-blue-600 dark:text-blue-400' : 
                          'text-yellow-600 dark:text-yellow-400'
                        }`}>
                          {subscription.status.charAt(0).toUpperCase() + subscription.status.slice(1)}
                        </span>
                      </div>
                      {subscription.current_period_end && (
                        <div className="flex justify-between">
                          <span className="text-gray-600 dark:text-gray-400">Renews on:</span>
                          <span className="font-medium text-gray-900 dark:text-white">
                            {formatDate(subscription.current_period_end)}
                          </span>
                        </div>
                      )}
                    </div>
                  )}

                  <div className="mt-6 space-y-3">
                    <Link 
                      href="/pricing"
                      className="block text-center w-full px-4 py-2 bg-indigo-600 border border-transparent rounded-md shadow-sm text-sm font-medium text-white 
                                hover:bg-indigo-700 dark:bg-indigo-500 dark:hover:bg-indigo-600 focus:outline-none focus:ring-2 focus:ring-offset-2 
                                focus:ring-indigo-500 dark:focus:ring-offset-gray-800"
                    >
                      {subscription ? 'Manage Subscription' : 'Upgrade Plan'}
                    </Link>
                    {subscription && (
                      <Link
                        href="/billing"
                        className="block text-center w-full px-4 py-2 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 
                                  rounded-md shadow-sm text-sm font-medium text-gray-700 dark:text-gray-300 
                                  hover:bg-gray-50 dark:hover:bg-gray-700"
                      >
                        Billing History
                      </Link>
                    )}
                  </div>
                </div>

                <div className="mt-6 bg-gray-50 dark:bg-gray-700 p-6 rounded-lg">
                  <h3 className="font-semibold text-lg text-gray-900 dark:text-white mb-4">
                    Account Security
                  </h3>
                  <div className="space-y-4">
                    <button 
                      className="block w-full text-left px-4 py-2 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 
                                rounded-md shadow-sm text-sm font-medium text-gray-700 dark:text-gray-300 
                                hover:bg-gray-50 dark:hover:bg-gray-700"
                    >
                      Change Password
                    </button>
                    <button 
                      className="block w-full text-left px-4 py-2 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 
                                rounded-md shadow-sm text-sm font-medium text-gray-700 dark:text-gray-300 
                                hover:bg-gray-50 dark:hover:bg-gray-700"
                    >
                      Two-Factor Authentication
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>
  );
};

export default ProfilePage;