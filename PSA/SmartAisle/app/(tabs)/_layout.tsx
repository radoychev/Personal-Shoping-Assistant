import { Tabs } from 'expo-router';
import React from 'react';

import { TabBarIcon } from '@/components/navigation/TabBarIcon';
import { Colors } from '@/constants/Colors';
import { useColorScheme } from '@/hooks/useColorScheme';
import {useFonts} from "expo-font";

export default function TabLayout() {
  const colorScheme = useColorScheme();
  

  return (
      <Tabs
          screenOptions={{
              tabBarStyle: {
                  backgroundColor: Colors[colorScheme ?? 'light'].background,
              },
              tabBarActiveTintColor: Colors[colorScheme ?? 'light'].tint,
              headerShown: false,
          }}>
          <Tabs.Screen
              name="index"
              options={{title: 'Home',
                  tabBarIcon: ({ color, focused }) => (
                      <TabBarIcon name={focused ? 'home' : 'home-outline'} color={color} />
                  ),
              }}
          />
          <Tabs.Screen
              name="list"
              options={{title: 'List',
                  tabBarIcon: ({ color, focused }) => (
                      <TabBarIcon name={focused ? 'list' : 'list-outline'} color={color} />
                  ),
              }}
          />
          <Tabs.Screen
              name="catalogue"
              options={{
                  title: 'Catalogue',
                  tabBarIcon: ({ color, focused }) => (
                      <TabBarIcon name={focused ? 'book' : 'book-outline'} color={color} />
                  ),
              }}
          />
          <Tabs.Screen
              name="scanner"
              options={{
                  title: 'AR Scanner',
                  tabBarIcon: ({ color, focused }) => (
                      <TabBarIcon name={focused ? 'search' : 'search-outline'} color={color} />
                  ),
              }}
          />
          <Tabs.Screen
              name="settings"
              options={{
                  title: 'Settings',
                  tabBarIcon: ({ color, focused }) => (
                      <TabBarIcon name={focused ? 'settings' : 'settings-outline'} color={color} />
                  ),
              }}
          />
      </Tabs>
  );
}
