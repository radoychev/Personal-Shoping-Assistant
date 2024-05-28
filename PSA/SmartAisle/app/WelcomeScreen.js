import React from 'react';
import { StyleSheet, Text, View, TouchableOpacity } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';

const WelcomeScreen = ({ navigate }) => {
    return (
        <LinearGradient
            colors={['#87CEEB', '#87CEFA']}
            style={styles.container}
        >
            <Text style={styles.title}>Welcome</Text>
            <Text style={styles.subtitle}>Do you have a SmartAisle account?</Text>
            <View style={styles.buttonContainer}>
                <TouchableOpacity
                    style={styles.button}
                    onPress={() => navigate('LoginScreen')}
                    accessibilityLabel="Navigate to Login Screen"
                >
                    <Text style={styles.buttonText}>Yes</Text>
                </TouchableOpacity>
                <TouchableOpacity
                    style={styles.button}
                    onPress={() => navigate('RegistrationScreen')}
                    accessibilityLabel="Navigate to Registration Screen"
                >
                    <Text style={styles.buttonText}>No</Text>
                </TouchableOpacity>
            </View>
        </LinearGradient>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    },
    title: {
        fontSize: 30,
        fontWeight: 'bold',
        color: 'white',
        marginBottom: 20,
    },
    subtitle: {
        fontSize: 18,
        color: 'white',
        marginBottom: 40,
        textAlign: 'center',
    },
    buttonContainer: {
        flexDirection: 'row',
        justifyContent: 'space-around',
        width: '80%',
    },
    button: {
        backgroundColor: 'white',
        padding: 15,
        width: 100,
        borderRadius: 10,
        justifyContent: 'center',
        alignItems: 'center',
        marginHorizontal: 10,
    },
    buttonText: {
        fontSize: 16,
        fontWeight: 'bold',
        color: '#87CEEB',
    },
});

export default WelcomeScreen;
