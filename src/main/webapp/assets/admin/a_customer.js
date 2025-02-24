const customers = <%= new Gson().toJson(request.getAttribute("customers")) %>;
    console.log(customers);

    $(document).ready(function() {
        // Reference to the table body
        const tableBody = $('#cusTbl tbody');

        // Iterate over each customer and construct table rows
        customers.forEach((customer, index) => {
            // Construct a table row with the customer data
            console.log(`My name is : ${customer.firstName} ${customer.lastName}`);
            const row = `
                <tr>
                    <td class="px-6 py-4 border-b border-gray-200">${customer.firstName}</td>
                    <td class="px-6 py-4 border-b border-gray-200">${customer.lastName}</td>
                    <td class="px-6 py-4 border-b border-gray-200">${customer.nic}</td>
                    <td class="px-6 py-4 border-b border-gray-200">${customer.email}</td>
                    <td class="px-6 py-4 border-b border-gray-200">${customer.phone}</td>
                    <td class="px-6 py-4 border-b border-gray-200">${customer.address}</td>
                    <td class="px-6 py-4 border-b border-gray-200">${customer.gender}</td>
                    <td class="px-6 py-4 border-b border-gray-200 text-yellow-500">${customer.membershipStatus}</td>
                    <td class="px-6 py-4 border-b border-gray-200">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M3 16.5v2.25A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75V16.5M16.5 12 12 16.5m0 0L7.5 12m4.5 4.5V3" />
                        </svg>
                    </td>
                </tr>
            `;


            // Append the row to the table body
            tableBody.append(row);
        });

        // Initialize DataTables with export buttons

    });