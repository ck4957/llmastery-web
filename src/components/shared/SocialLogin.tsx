import { useState } from 'react';
import { useAuth } from '@/lib/auth-context';
import { Provider } from '@supabase/supabase-js';

interface SocialLoginProps {
  setAuthError?: (error: string | null) => void;
}

const SocialLogin = ({ setAuthError }: SocialLoginProps) => {
  const { signInWithSocial } = useAuth();
  const [isLoading, setIsLoading] = useState<Record<Provider, boolean>>({
    google: false,
    github: false,
    twitter: false,
    azure: false,
    bitbucket: false,
    discord: false,
    facebook: false,
    figma: false,
    gitlab: false,
    keycloak: false,
    linkedin: false,
    notion: false,
    slack: false,
    spotify: false,
    twitch: false,
    workos: false,
    apple: false,
    kakao: false,
    linkedin_oidc: false,
    slack_oidc: false,
    zoom: false,
    fly: false,
  });

  const handleSocialLogin = async (provider: Provider) => {
    try {
      setIsLoading(prev => ({ ...prev, [provider]: true }));
      if (setAuthError) setAuthError(null);
      await signInWithSocial(provider);
    } catch (error) {
      if (setAuthError) {
        setAuthError(`Failed to authenticate with ${provider}. Please try again.`);
      }
      console.error(`Error signing in with ${provider}:`, error);
    } finally {
      setIsLoading(prev => ({ ...prev, [provider]: false }));
    }
  };

  return (
    <div className="space-y-4 w-full">
      <div className="relative">
        <div className="absolute inset-0 flex items-center">
          <div className="w-full border-t border-gray-300 dark:border-gray-700"></div>
        </div>
        <div className="relative flex justify-center text-sm">
          <span className="px-2 bg-white dark:bg-gray-800 text-gray-500 dark:text-gray-400">
            Or continue with
          </span>
        </div>
      </div>

      <div className="grid grid-cols-3 gap-3">
        <button
          type="button"
          onClick={() => handleSocialLogin('google')}
          disabled={isLoading.google}
          className="flex justify-center items-center w-full py-2.5 px-4 rounded-md border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600 transition-colors"
        >
          {isLoading.google ? (
            <div className="h-5 w-5 border-t-2 border-b-2 border-gray-600 dark:border-gray-300 rounded-full animate-spin"></div>
          ) : (
            <svg width="20" height="20" fill="currentColor" className="text-[#4285F4]">
              <path d="M19.99 10.187c0-.82-.069-1.417-.216-2.037H10.2v3.698h5.62c-.113.92-.725 2.303-2.084 3.233l-.02.124 3.028 2.292.21.02c1.926-1.738 3.037-4.296 3.037-7.33z" fill="currentColor"/>
              <path d="M10.2 19.931c2.753 0 5.064-.886 6.753-2.414l-3.218-2.436c-.862.587-2.017.997-3.536.997a6.126 6.126 0 0 1-5.801-4.141l-.12.01-3.148 2.38-.041.112c1.677 3.256 5.122 5.492 9.11 5.492z" fill="#34A853"/>
              <path d="M4.398 11.937a6.008 6.008 0 0 1-.34-1.971c0-.687.125-1.351.329-1.971l-.006-.132-3.188-2.42-.104.05A9.79 9.79 0 0 0 .001 9.965a9.79 9.79 0 0 0 1.088 4.473l3.309-2.502z" fill="#FBBC05"/>
              <path d="M10.2 3.853c1.914 0 3.206.809 3.943 1.484l2.878-2.746C15.253.985 12.953 0 10.199 0 6.211 0 2.766 2.237 1.09 5.492l3.297 2.503A6.152 6.152 0 0 1 10.2 3.853z" fill="#EA4335"/>
            </svg>
          )}
        </button>

        <button
          type="button"
          onClick={() => handleSocialLogin('github')}
          disabled={isLoading.github}
          className="flex justify-center items-center w-full py-2.5 px-4 rounded-md border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600 transition-colors"
        >
          {isLoading.github ? (
            <div className="h-5 w-5 border-t-2 border-b-2 border-gray-600 dark:border-gray-300 rounded-full animate-spin"></div>
          ) : (
            <svg width="20" height="20" fill="currentColor" className="text-gray-900 dark:text-white">
              <path fillRule="evenodd" clipRule="evenodd" d="M10 0C4.477 0 0 4.477 0 10c0 4.42 2.87 8.17 6.84 9.5.5.08.66-.22.66-.48v-1.69c-2.77.6-3.36-1.34-3.36-1.34-.46-1.16-1.11-1.47-1.11-1.47-.91-.62.07-.6.07-.6 1 .07 1.53 1.03 1.53 1.03.9 1.52 2.34 1.08 2.91.83.09-.65.35-1.09.63-1.34-2.22-.25-4.55-1.11-4.55-4.94 0-1.09.39-1.98 1.03-2.68-.1-.25-.45-1.27.1-2.64 0 0 .84-.27 2.75 1.02.8-.22 1.65-.33 2.5-.33.85 0 1.7.11 2.5.33 1.91-1.29 2.75-1.02 2.75-1.02.55 1.37.2 2.39.1 2.64.64.7 1.03 1.59 1.03 2.68 0 3.84-2.34 4.68-4.57 4.93.36.31.68.92.68 1.85v2.74c0 .27.16.57.67.48C17.14 18.16 20 14.42 20 10c0-5.523-4.477-10-10-10z" />
            </svg>
          )}
        </button>

        <button
          type="button"
          onClick={() => handleSocialLogin('twitter')}
          disabled={isLoading.twitter}
          className="flex justify-center items-center w-full py-2.5 px-4 rounded-md border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600 transition-colors"
        >
          {isLoading.twitter ? (
            <div className="h-5 w-5 border-t-2 border-b-2 border-gray-600 dark:border-gray-300 rounded-full animate-spin"></div>
          ) : (
            <svg width="20" height="20" fill="currentColor" className="text-[#1DA1F2]">
              <path d="M6.29 18.251c7.547 0 11.675-6.253 11.675-11.675 0-.178 0-.355-.012-.53A8.348 8.348 0 0020 3.92a8.19 8.19 0 01-2.357.646 4.118 4.118 0 001.804-2.27 8.224 8.224 0 01-2.605.996 4.107 4.107 0 00-6.993 3.743 11.65 11.65 0 01-8.457-4.287 4.106 4.106 0 001.27 5.477A4.073 4.073 0 01.8 7.713v.052a4.105 4.105 0 003.292 4.022 4.095 4.095 0 01-1.853.07 4.108 4.108 0 003.834 2.85A8.233 8.233 0 010 16.407a11.616 11.616 0 006.29 1.84" />
            </svg>
          )}
        </button>
      </div>
    </div>
  );
};

export default SocialLogin;