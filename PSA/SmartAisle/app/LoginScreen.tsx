import React, { useState } from "react";
import {
    View,
    Text,
    TextInput,
    TouchableOpacity,
    StyleSheet,
} from "react-native";
import { LinearGradient } from "expo-linear-gradient";
import Icon from "react-native-vector-icons/MaterialIcons";
import { Link } from "expo-router";

const LoginScreen = () => {
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");

    return (
        <LinearGradient colors={["#ffffff", "#1E82AE"]} style={styles.container}>
            <Text style={styles.title}>Welcome Back!</Text>
            <View style={styles.inputContainer}>
                <Icon name="email" size={20} color="#000" style={styles.icon} />
                <TextInput
                    style={styles.input}
                    placeholder="email@gmail.com"
                    value={email}
                    onChangeText={setEmail}
                    keyboardType="email-address"
                />
            </View>
            <View style={styles.inputContainer}>
                <Icon name="lock" size={20} color="#000" style={styles.icon} />
                <TextInput
                    style={styles.input}
                    placeholder="********"
                    value={password}
                    onChangeText={setPassword}
                    secureTextEntry
                />
            </View>
            <TouchableOpacity style={styles.button}>
                <Link href="/home" style={styles.buttonText}>Login</Link>
            </TouchableOpacity>
            <TouchableOpacity style={styles.link}>
                <Link href="/forgot-password" style={styles.linkText}>Forgot Password?</Link>
            </TouchableOpacity>
            <TouchableOpacity style={styles.link}>
                <Link href="/create-account" style={styles.linkText}>Create an Account</Link>
            </TouchableOpacity>
        </LinearGradient>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: "center",
        alignItems: "center",
        padding: 20,
    },
    title: {
        fontSize: 24,
        color: "#000",
        marginBottom: 40,
        fontWeight: "bold",
    },
    inputContainer: {
        width: "100%",
        flexDirection: "row",
        alignItems: "center",
        marginBottom: 20,
        backgroundColor: "#FFF",
        borderRadius: 30,
        paddingHorizontal: 10,
    },
    input: {
        flex: 1,
        padding: 15,
        textAlign: "center",
    },
    icon: {
        marginLeft: 20,
    },
    button: {
        backgroundColor: "#FFF",
        padding: 15,
        borderRadius: 30,
        width: "100%",
        alignItems: "center",
        marginTop: 20,
    },
    buttonText: {
        color: "#000",
        fontWeight: "bold",
    },
    link: {
        marginTop: 10,
    },
    linkText: {
        color: "#000",
        textDecorationLine: "underline",
        fontSize: 15, // Increased font size
    },
});

export default LoginScreen;
