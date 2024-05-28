import React from "react";
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  StyleSheet,
  Dimensions,
} from "react-native";
import Icon from "react-native-vector-icons/MaterialIcons";
//import Footer from "../components/Footer";

const { height } = Dimensions.get("window");

// Define the type for your props
type SearchScreenProps = {
  navigate: (screen: string) => void;
};

const SearchScreen: React.FC<SearchScreenProps> = ({ navigate }) => {
  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>Search</Text>
        <TouchableOpacity onPress={() => navigate("HomeScreen")}>
          <Icon name="home" size={28} color="#000" />
        </TouchableOpacity>
      </View>
      <TextInput
        style={styles.searchBar}
        placeholder="Search..."
        placeholderTextColor="#888"
      />
      <View style={styles.grid}>
        <View style={styles.placeholder} />
        <View style={styles.placeholder} />
        <View style={styles.placeholder} />
        <View style={styles.placeholder} />
        <View style={styles.placeholder} />
        <View style={styles.placeholder} />
      </View>
      <View style={styles.footerWrapper}>
         
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#1E82AE",
    padding: 20,
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
  searchBar: {
    backgroundColor: "#FFF",
    borderRadius: 10,
    padding: 10,
    marginBottom: 20,
    color: "#000",
  },
  grid: {
    flexDirection: "row",
    flexWrap: "wrap",
    justifyContent: "space-between",
  },
  placeholder: {
    width: "48%",
    height: 100,
    backgroundColor: "#247BA0",
    borderRadius: 10,
    marginBottom: 10,
  },
  footerWrapper: {
    position: "absolute",
    top: height / 2 - 30, // Position footer in the middle of the screen
    width: "100%",
    paddingLeft: 10,
    marginTop: 390,
    marginLeft: 25,
  },
});

export default SearchScreen;
