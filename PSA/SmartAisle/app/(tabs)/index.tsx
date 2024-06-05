import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet, Image } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { Link } from "expo-router";
import { MaterialIcons } from '@expo/vector-icons';
import LoginScreen from '../LoginScreen';

export default function HomeScreen() {
  return (
    <View style={styles.container}>
      <Text style={styles.helloText}>Hello, World!</Text>

      <TouchableOpacity style={styles.button}>
        <Link href="LoginScreen" style={styles.buttonText}>Go to Page 1</Link>
      </TouchableOpacity>

      <TouchableOpacity style={styles.button}>
        <Link href="/page2" style={styles.buttonText}>Go to Page 2</Link>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  helloText: {
    fontSize: 20,
    color: '#000',
  },
  button: {
    backgroundColor: '#007BFF',
    padding: 10,
    borderRadius: 5,
    marginTop: 10,
  },
  buttonText: {
    color: '#fff',
    fontSize: 16,
  },
  headerImage: {
    color: '#808080',
    bottom: -90,
    left: -35,
    position: 'absolute',
  },
  titleContainer: {
    flexDirection: 'row',
    gap: 8,
  },
});
