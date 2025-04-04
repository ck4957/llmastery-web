'use client';

import { ApolloClient, ApolloProvider, InMemoryCache } from '@apollo/client';
import { ReactNode, useState } from 'react';

export function ApolloWrapper({ children }: { children: ReactNode }) {
  // Create Apollo client on the client side
  const [client] = useState(() => new ApolloClient({
    uri: process.env.NEXT_PUBLIC_GRAPHQL_API_URL || 'http://localhost:4000/graphql',
    cache: new InMemoryCache(),
    connectToDevTools: true,
  }));

  return (
    <ApolloProvider client={client}>
      {children}
    </ApolloProvider>
  );
}