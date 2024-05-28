import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet, Image } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import {Link} from "expo-router";

export default function SettingsScreen() {
  return (
      <View style={styles.container}>
        <View style={styles.header}>
          <Text style={styles.headerTitle}>Settings</Text>
        </View>
        <View style={styles.titleContainer}>
          <TouchableOpacity style={styles.button}>
            <Text style={styles.buttonText}>Change password</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.button}>
            <Text style={styles.buttonText}>Pair shopping lists</Text>
          </TouchableOpacity>
          <Link href="/about" asChild>
            <TouchableOpacity style={styles.button}>
              <Text style={styles.buttonText}>About</Text>
            </TouchableOpacity>
          </Link>
        </View>
      </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#457fa2',
    alignItems: 'center',
    padding: 20,
  },
  header: {
    width: '95%',
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginTop: 50,
  },
  headerTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#ffffff',
  },
  homeIcon: {
    color: '#ffffff',
  },
  titleContainer: {
    width: '80%',
    marginTop: '50%',
  },
  button: {
    width: '100%',
    padding: 20,
    backgroundColor: 'rgba(24,24,24,0.45)',
    borderRadius: 10,
    alignItems: 'center',
    marginVertical: 10,
    justifyContent: 'center',
    marginTop: 20,
  },
  buttonText: {
    fontSize: 18,
    color: '#ffffff',
    fontWeight: 'bold',
  },
});
