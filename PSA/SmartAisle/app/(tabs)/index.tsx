import React from 'react';
import {View, Text, TouchableOpacity, StyleSheet, Image} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import {Link} from "expo-router";
import { MaterialIcons } from '@expo/vector-icons';

export default function HomeScreen() {
  // return (
  //  
  // );
}

const styles = StyleSheet.create({
  titleContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
  },
  stepContainer: {
    gap: 8,
    marginBottom: 8,
  },
  reactLogo: {
    height: 178,
    width: 290,
    bottom: 0,
    left: 0,
    position: 'absolute',
  },
});
