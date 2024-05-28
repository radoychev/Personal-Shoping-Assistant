import { StyleSheet, Text, View } from 'react-native';

export default function HomeNewUser() {
  return (
    <View style={styles.container}>
      <View style={styles.margin}>
        <Text style={styles.title}>Welcome User!</Text>
        <Text style={styles.title}>Weekly Deals</Text>
        <View style={styles.boxContainer}>
          <View style={styles.box}></View>
          <View style={styles.box}></View>
          <View style={styles.box}></View>
        </View>
        <View style={styles.boxContainer}>
          <View style={styles.box}></View>
          <View style={styles.box}></View>
          <View style={styles.box}></View>
        </View>
        <Text style={styles.title}>Get Started With</Text>
        <View style={styles.boxContainer}>
          <View style={styles.box}></View>
          <View style={styles.box}></View>
          <View style={styles.box}></View>
        </View>
        <View style={styles.boxContainer}>
          <View style={styles.box}></View>
          <View style={styles.box}></View>
          <View style={styles.box}></View>
        </View>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    backgroundColor: '#457fa2',
  },
  margin: {
    margin: 15,
    backgroundColor: "transparent",
  },
  boxContainer: {
    flexDirection: 'row',
    justifyContent: 'space-evenly',
    flexWrap: 'wrap',
    backgroundColor: "transparent",
    marginBottom: 20,
  },
  box: {
    backgroundColor: 'grey',
    width: 100,
    height: 100,
    borderRadius: 10,
    opacity: 0.6,
  
  },
  title: {
    fontSize: 20,
    fontWeight: 'bold',
    color: 'white',
    marginBottom: 20,
    marginTop: 20,
  },
});
