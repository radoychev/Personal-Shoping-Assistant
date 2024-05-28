import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import {Link} from "expo-router";
import { MaterialIcons } from '@expo/vector-icons';

export default function SettingsScreen() {
    return (
        <View style={styles.container}>
            <View style={styles.header}>
                <Text style={styles.headerTitle}>About</Text>
            </View>
            <View style={styles.titleContainer}>
                <View style={styles.button}>
                    <View style={styles.icon}>
                        <MaterialIcons name="info-outline" size={50} color={"black"} style={styles.infoIcon} />
                    </View>
                    <Text style={styles.buttonText}>Application Version</Text>
                    <Text style={styles.buttonTextSmall}>1.0.0</Text>
                    <Text style={styles.buttonText}>Copyright</Text>
                    <Text style={styles.buttonTextSmall}>NHL Stenden Hogeschool - 2024</Text>
                    <Text style={styles.buttonText}>Security Version</Text>
                    <Text style={styles.buttonTextSmall}>1.0.0</Text>
                </View>
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
        marginTop: '20%',
    },
    button: {
        width: '100%',
        padding: 20,
        backgroundColor: 'rgba(24,24,24,0.45)',
        borderRadius: 10,
        marginVertical: 10,
        justifyContent: 'center',
        marginTop: 20,
    },
    buttonText: {
        fontSize: 18,
        color: '#ffffff',
        fontWeight: 'bold',
    },
    buttonTextSmall: {
        fontSize: 14,
        color: '#ffffff',
        fontWeight: 'normal',
        paddingTop: 15,
        paddingBottom: 30,
        marginLeft: 15,
    },
    icon: {
        alignItems: 'center',
        justifyContent: 'center',
        paddingBottom: 40,
    },
    infoIcon: {
        color: '#ffffff',
    },
});
