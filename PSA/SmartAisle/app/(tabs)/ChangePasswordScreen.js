import React, { useState } from "react";
import {
    View,
    Text,
    TextInput,
    TouchableOpacity,
    StyleSheet,
} from "react-native";
import Icon from "react-native-vector-icons/MaterialIcons";
import Footer from "../components/Footer";

const ChangePasswordScreen = ({ navigate }) => {
    const [oldPassword, setOldPassword] = useState("");
    const [newPassword, setNewPassword] = useState("");

    return (
        <View style={styles.container}>
            <Text style={styles.title}>Change Password</Text>
            <View style={styles.passwordContainer}>
                <Text style={styles.label}>Old Password</Text>
                <View style={styles.inputContainer}>
                    <Icon name="lock" size={20} color="#000" style={styles.icon} />
                    <TextInput
                        style={styles.input}
                        placeholder="********"
                        value={oldPassword}
                        onChangeText={setOldPassword}
                        secureTextEntry
                    />
                </View>
            </View>
            <View style={styles.passwordContainer}>
                <Text style={styles.label}>New Password</Text>
                <View style={styles.inputContainer}>
                    <Icon name="lock" size={20} color="#000" style={styles.icon} />
                    <TextInput
                        style={styles.input}
                        placeholder="********"
                        value={newPassword}
                        onChangeText={setNewPassword}
                        secureTextEntry
                    />
                </View>
            </View>
            <TouchableOpacity
                style={styles.confirmButton}
                onPress={() => alert("Password Changed")}
            >
                <Text style={styles.buttonText}>Confirm</Text>
            </TouchableOpacity>
            <TouchableOpacity
                style={styles.cancelButton}
                onPress={() => navigate("ProfileScreen")}
            >
                <Text style={styles.buttonText}>Cancel</Text>
            </TouchableOpacity>
            <Footer navigate={navigate} />
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: "center",
        alignItems: "center",
        backgroundColor: "#1E82AE",
        padding: 20,
    },
    title: {
        fontSize: 24,
        color: "#FFF",
        marginBottom: 20,
        fontWeight: "bold",
    },
    passwordContainer: {
        backgroundColor: "#247BA0",
        padding: 20,
        borderRadius: 10,
        marginBottom: 20,
        width: "100%",
    },
    label: {
        color: "#FFF",
        marginBottom: 10,
        fontWeight: "bold",
    },
    inputContainer: {
        flexDirection: "row",
        alignItems: "center",
        backgroundColor: "#FFF",
        borderRadius: 30,
        paddingHorizontal: 10,
    },
    input: {
        flex: 1,
        padding: 10,
        borderRadius: 30,
        textAlign: "center",
    },
    icon: {
        marginLeft: 20,
    },
    confirmButton: {
        backgroundColor: "#FFF",
        padding: 15,
        borderRadius: 30,
        width: "90%",
        alignItems: "center",
        marginTop: 5,
    },
    cancelButton: {
        backgroundColor: "#FF6B6B",
        padding: 15,
        borderRadius: 30,
        width: "90%",
        alignItems: "center",
        marginTop: 20,
    },
    buttonText: {
        color: "#000",
        fontWeight: "bold",
    },
});


export default ChangePasswordScreen;