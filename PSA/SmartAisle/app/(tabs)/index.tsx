import React, { useState } from "react";
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  StyleSheet,
  Alert,
} from "react-native";
import Icon from "react-native-vector-icons/MaterialIcons";
import Entypo from "react-native-vector-icons/Entypo";
import FontAwesome from "react-native-vector-icons/FontAwesome";
//import Footer from "../components/Footer";

const PairShoppingListScreen = ({ navigate }) => {
  const [email, setEmail] = useState("");

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>Pair Shopping List</Text>
        <TouchableOpacity onPress={() => navigate("HomeScreen")}>
          <FontAwesome name="home" size={28} color="#000" />
        </TouchableOpacity>
      </View>
      <View style={styles.formContainer}>
        <Text style={styles.label}>Email Address</Text>
        <View style={styles.inputContainer}>
          <FontAwesome name="at" size={20} color="#000" style={styles.icon} />
          <TextInput
            style={styles.input}
            placeholder="email@gmail.com"
            value={email}
            onChangeText={setEmail}
            keyboardType="email-address"
          />
        </View>
      </View>
      <TouchableOpacity
        style={styles.confirmButton}
        onPress={() => Alert.alert("Email Submitted")}
      >
        <Text style={styles.buttonText}>Confirm</Text>
      </TouchableOpacity>
      <TouchableOpacity
        style={styles.cancelButton}
        onPress={() => navigate("HomeScreen")}
      >
        <Text style={styles.buttonText}>Cancel</Text>
      </TouchableOpacity>
      
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#1E82AE",
    padding: 20,
    paddingBottom: 80, // To ensure the content does not overlap with the footer
  },
  header: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: 20,
  },
  title: {
    fontSize: 24,
    color: "#FFF",
    fontWeight: "bold",
  },
  formContainer: {
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
    padding: 15,
    textAlign: "center",
  },
  icon: {
    marginRight: 10,
  },
  confirmButton: {
    backgroundColor: "#FFF",
    padding: 15,
    borderRadius: 30,
    width: "90%",
    alignItems: "center",
    marginTop: 5,
    alignSelf: "center",
  },
  cancelButton: {
    backgroundColor: "#FF6B6B",
    padding: 15,
    borderRadius: 30,
    width: "90%",
    alignItems: "center",
    marginTop: 20,
    alignSelf: "center",
  },
  buttonText: {
    color: "#000",
    fontWeight: "bold",
  },
});

export default PairShoppingListScreen;
