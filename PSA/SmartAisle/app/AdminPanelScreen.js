import React, { useState } from 'react';
import { View, Text, TextInput, StyleSheet, TouchableOpacity } from 'react-native';

const AdminPanelScreen = () => {
    const [item, setItem] = useState({ number: '', price: '', quantity: '' });
    const [newItem, setNewItem] = useState({ number: '', price: '', quantity: '' });

    // Handle updates to the existing item form
    const handleEditChange = (name, value) => {
        setItem({ ...item, [name]: value });
    };

    // Handle updates to the new item form
    const handleAddChange = (name, value) => {
        setNewItem({ ...newItem, [name]: value });
    };

    const handleSave = () => {
        console.log('Saving:', item);
    };

    const handleAdd = () => {
        console.log('Adding:', newItem);
    };

    const handleDelete = () => {
        console.log('Deleting item number:', item.number);
    };

    return (
        <View style={styles.container}>
            <Text style={styles.header}>Admin Panel</Text>

            <View style={styles.card}>
                <Text style={styles.cardTitle}>Edit Products</Text>
                <TextInput
                    placeholder="Item #"
                    value={item.number}
                    onChangeText={(text) => handleEditChange('number', text)}
                    style={styles.input}
                />
                <TextInput
                    placeholder="Price"
                    value={item.price}
                    onChangeText={(text) => handleEditChange('price', text)}
                    style={styles.input}
                />
                <TextInput
                    placeholder="Quantity"
                    value={item.quantity}
                    onChangeText={(text) => handleEditChange('quantity', text)}
                    style={styles.input}
                />
                <View style={styles.buttonRow}>
                    <TouchableOpacity onPress={handleDelete} style={[styles.button, styles.deleteButton]}>
                        <Text style={styles.buttonText}>Delete</Text>
                    </TouchableOpacity>
                    <TouchableOpacity onPress={handleSave} style={styles.button}>
                        <Text style={styles.buttonText}>Save</Text>
                    </TouchableOpacity>
                </View>
            </View>

            <View style={styles.card}>
                <Text style={styles.cardTitle}>Add Products</Text>
                <TextInput
                    placeholder="Item #"
                    value={newItem.number}
                    onChangeText={(text) => handleAddChange('number', text)}
                    style={styles.input}
                />
                <TextInput
                    placeholder="Price"
                    value={newItem.price}
                    onChangeText={(text) => handleAddChange('price', text)}
                    style={styles.input}
                />
                <TextInput
                    placeholder="Quantity"
                    value={newItem.quantity}
                    onChangeText={(text) => handleAddChange('quantity', text)}
                    style={styles.input}
                />
                <TouchableOpacity onPress={handleAdd} style={styles.button}>
                    <Text style={styles.buttonText}>Add</Text>
                </TouchableOpacity>
            </View>
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: 'center',
        backgroundColor: '#87CEEB',
        padding: 20,
    },
    header: {
        fontSize: 24,
        fontWeight: 'bold',
        marginBottom: 20,
    },
    card: {
        backgroundColor: 'white',
        width: '100%',
        padding: 20,
        borderRadius: 10,
        marginBottom: 20,
    },
    cardTitle: {
        fontSize: 18,
        fontWeight: 'bold',
        marginBottom: 10,
    },
    input: {
        borderWidth: 1,
        borderColor: '#ccc',
        padding: 10,
        borderRadius: 5,
        marginBottom: 10,
        width: '100%',
    },
    buttonRow: {
        flexDirection: 'row',
        justifyContent: 'space-between',
    },
    button: {
        backgroundColor: '#ccc',
        padding: 10,
        borderRadius: 5,
        alignItems: 'center',
        marginTop: 10,
    },
    deleteButton: {
        backgroundColor: '#f88',
    },
    buttonText: {
        color: '#000',
        fontWeight: 'bold',
    },
});

export default AdminPanelScreen;
