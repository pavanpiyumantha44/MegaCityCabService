package com.cab.mega.dao;

import com.cab.mega.model.Customer;

import java.util.List;

public interface CustomerDao {
    public void addCustomer(Customer customer);
    public List<Customer> getAllCustomers();
    public Customer getCustomerById(int customerId);
    public boolean updateCustomer(Customer customer, int id);
    public boolean deleteCustomer(int id);
}
