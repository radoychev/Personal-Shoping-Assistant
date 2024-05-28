import { StyleSheet, Text, View, TouchableOpacity, ScrollView } from 'react-native';

export default function ShoppingList() {
  return (
    <View style={styles.container}>
      <View style={styles.margin}>
        <View style={styles.header}>
            <Text style={[styles.text, { marginRight: 15}]}>My Shopping List</Text>
            <Text style={styles.text}>Total: €10.00</Text>
        </View>
        <ScrollView contentContainerStyle={styles.boxContainer}>
            <View>
                <View style={styles.productContainer}>
                    <TouchableOpacity style={styles.box}></TouchableOpacity>
                    <Text style={styles.text}>Product 1</Text>
                </View>
                <View style={styles.productContainer}>
                    <TouchableOpacity style={styles.box}></TouchableOpacity>
                    <Text style={styles.text}>Product 2</Text>
                </View>
                <View style={styles.productContainer}>
                    <TouchableOpacity style={styles.box}></TouchableOpacity>
                    <Text style={styles.text}>Product 3</Text>
                </View>
                <View style={styles.productContainer}>
                    <TouchableOpacity style={styles.box}></TouchableOpacity>
                    <Text style={styles.text}>Product 4</Text>
                </View>
                <View style={styles.productContainer}>
                    <TouchableOpacity style={styles.box}></TouchableOpacity>
                    <Text style={styles.text}>Product 5</Text>
                </View>
                <View style={styles.productContainer}>
                    <TouchableOpacity style={styles.box}></TouchableOpacity>
                    <Text style={styles.text}>Product 6</Text>
                </View>
                <View style={styles.productContainer}>
                    <TouchableOpacity style={styles.box}></TouchableOpacity>
                    <Text style={styles.text}>Product 7</Text>
                </View>
          </View>
        </ScrollView>
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
    margin: 50,
    backgroundColor: "transparent",
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  boxContainer: {
    flexDirection: 'column',
    flexWrap: 'wrap',
    backgroundColor: "transparent",
    alignContent: 'center',
    alignItems: 'center',
  },
  productContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    backgroundColor: "transparent",
    alignItems: 'center',
  },
  box: {
    backgroundColor: 'grey',
    width: 100,
    height: 100,
    borderRadius: 10,
    opacity: 0.6,
    margin: 15,
  
  },
  text: {
    fontSize: 20,
    fontWeight: 'bold',
    color: 'white',
    marginBottom: 20,
    marginTop: 20,
  },
});
