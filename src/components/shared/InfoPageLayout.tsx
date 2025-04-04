import Link from 'next/link';
import { ReactNode } from 'react';
import DarkModeToggle from './DarkModeToggle';

interface InfoPageLayoutProps {
  children: ReactNode;
  title: string;
  description?: string;
}

export default function InfoPageLayout({ children, title, description }: InfoPageLayoutProps) {
  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      {/* Header */}
      <header className="bg-white dark:bg-gray-800 shadow-sm">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4 flex justify-between items-center">
          <div className="flex items-center">
            <Link href="/" className="flex items-center">
              <span className="text-2xl font-bold text-indigo-600 dark:text-indigo-400">LLMastery</span>
            </Link>
          </div>
          <div className="flex items-center">
            <nav className="mr-6 space-x-8 hidden md:flex">
              <Link href="/dashboard" className="text-gray-500 hover:text-gray-700 dark:text-gray-300 dark:hover:text-white">
                Dashboard
              </Link>
              <Link href="/about" className="text-gray-500 hover:text-gray-700 dark:text-gray-300 dark:hover:text-white">
                About
              </Link>
              <Link href="/pricing" className="text-gray-500 hover:text-gray-700 dark:text-gray-300 dark:hover:text-white">
                Pricing
              </Link>
              <Link href="/contact" className="text-gray-500 hover:text-gray-700 dark:text-gray-300 dark:hover:text-white">
                Contact
              </Link>
            </nav>
            <DarkModeToggle />
          </div>
        </div>
      </header>

      {/* Page Header */}
      <div className="bg-indigo-600 dark:bg-indigo-800">
        <div className="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8 text-center">
          <h1 className="text-3xl md:text-4xl font-extrabold text-white">{title}</h1>
          {description && (
            <p className="mt-4 text-xl text-indigo-100 max-w-3xl mx-auto">
              {description}
            </p>
          )}
        </div>
      </div>

      {/* Main Content */}
      <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div className="bg-white dark:bg-gray-800 shadow-sm rounded-lg p-6 md:p-8">
          {children}
        </div>
      </main>

      {/* Footer */}
      <footer className="bg-white dark:bg-gray-800 border-t border-gray-200 dark:border-gray-700">
        <div className="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
          <div className="md:flex md:items-center md:justify-between">
            <div className="flex justify-center md:justify-start">
              <Link href="/" className="text-indigo-600 dark:text-indigo-400 font-bold text-xl">
                LLMastery
              </Link>
            </div>
            <div className="mt-8 md:mt-0">
              <p className="text-center md:text-right text-sm text-gray-500 dark:text-gray-400">
                &copy; {new Date().getFullYear()} LLMastery. All rights reserved.
              </p>
            </div>
          </div>
          <div className="mt-8 border-t border-gray-200 dark:border-gray-700 pt-8">
            <div className="flex justify-center space-x-6">
              <Link href="/terms" className="text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-300 text-sm">
                Terms of Service
              </Link>
              <Link href="/refund-policy" className="text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-300 text-sm">
                Refund Policy
              </Link>
              <Link href="/pricing" className="text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-300 text-sm">
                Pricing
              </Link>
              <Link href="/contact" className="text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-300 text-sm">
                Contact
              </Link>
            </div>
          </div>
        </div>
      </footer>
    </div>
  );
}