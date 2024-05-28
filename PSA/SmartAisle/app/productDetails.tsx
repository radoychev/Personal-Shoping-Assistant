import React from 'react';
import {View, Text, TouchableOpacity, StyleSheet, Image} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import {Link} from "expo-router";
import { MaterialIcons } from '@expo/vector-icons';

export default function SettingsScreen() {
    return (
        <View style={styles.container}>
            <View style={styles.titleContainer}>
                <View style={styles.productName}>
                    <Text style={styles.headerTitle}>Product Name</Text>
                </View>
                <View style={styles.button}>
                    <Image source={require('../assets/images/milk.png')} style={styles.image} />
                    <Text style={styles.productText}>Happily Milked from Happy Cows!</Text>
                    <Text style={styles.productPrice}>Price: € 10,95</Text>
                    <TouchableOpacity>
                        <View style={styles.addToCartButton}>
                            <Text style={styles.addToCart}>Add to My List</Text>
                        </View>
                    </TouchableOpacity>

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
        justifyContent: 'center',
        alignItems: 'center',
        marginTop: 80,
    },
    headerTitle: {
        fontSize: 24,
        fontWeight: 'bold',
        color: '#ffffff',
        marginTop: 50,
    },
    homeIcon: {
        color: '#ffffff',
    },
    titleContainer: {
        width: '80%',
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
    image: {
        width: 250,
        height: 250,
        borderRadius: 10,
        flexDirection: 'row',
        justifyContent: 'center',
        marginTop: 25,
    },
    productName: {
        flexDirection: 'row',
        justifyContent: 'center',
        alignItems: 'center',
        marginTop: 50,
    },
    productText: {
        flexDirection: 'row',
        justifyContent: 'center',
        textAlign: 'center',
        marginTop: 25,
        fontSize: 18,
        fontWeight: 'bold',
        color: '#ffffff',
    },
    productPrice: {
        flexDirection: 'row',
        justifyContent: 'center',
        textAlign: 'center',
        marginTop: 25,
        fontSize: 18,
        fontWeight: 'bold',
        color: '#ffffff',
    },
    addToCart: {
        flexDirection: 'row',
        justifyContent: 'center',
        textAlign: 'center',
        fontWeight: 'bold',

    },
    addToCartButton:{
        flexDirection: 'row',
        justifyContent: 'center',
        alignItems: 'center',
        marginTop: 25,
        padding: 10,
        backgroundColor: 'rgba(218,218,218,0.77)',
        borderRadius: 10,
        marginVertical: 10,
    }
});
