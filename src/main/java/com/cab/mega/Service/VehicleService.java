package com.cab.mega.Service;

import com.cab.mega.dao.VehicleDao;
import com.cab.mega.dao.VehicleDaoImpl;
import com.cab.mega.model.CommonResponseModel;
import com.cab.mega.model.Driver;
import com.cab.mega.model.Vehicle;
import com.cab.mega.utils.database.DBConnectionFactory;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class VehicleService {
    private static VehicleService vehicleService;
    VehicleDao vehicleDao;
    private VehicleService(){
        this.vehicleDao = new VehicleDaoImpl();
    }
    public static VehicleService getInstance() {
        if (vehicleService == null) {
            synchronized (VehicleService.class) {
                if (vehicleService == null) {
                    vehicleService = new VehicleService();
                }
            }
        }
        return vehicleService;
    }
    public CommonResponseModel addVehicle(Vehicle vehicle, List<String>imagePaths) throws SQLException {
        Connection connection = null;
        String VIN_REGEX = "^[A-HJ-NPR-Z0-9]{17}$";
        String REGISTRATION_NUMBER_REGEX = "^[A-Z0-9-]{6,50}$";

        Pattern vinPattern = Pattern.compile(VIN_REGEX);
        Matcher vinMatcher = vinPattern.matcher(vehicle.getVin());

        Pattern regNumberPattern = Pattern.compile(REGISTRATION_NUMBER_REGEX);
        Matcher regNumberMatcher = regNumberPattern.matcher(vehicle.getRegistrationNumber());


        if (vehicle.getModel().length() > 30 || vehicle.getModel().isEmpty()) {
            return new CommonResponseModel("Invalid Vehicle Model", false, null);
        } else if (vehicle.getMake().length() > 30 || vehicle.getMake().isEmpty()) {
            return new CommonResponseModel("Invalid Vehicle Make", false, null);
        } else if (!vinMatcher.matches()) {
            return new CommonResponseModel("Invalid VIN", false, null);
        }else if (!regNumberMatcher.matches()) {
            return new CommonResponseModel("Invalid Registration Number", false, null);
        } else if (vehicle.getVehicleType().isEmpty()) {
            return new CommonResponseModel("Invalid Vehicle Type", false, null);
        } else if (vehicle.getNoOfSeats() < 4) {
            return new CommonResponseModel("Invalid No Of Seats", false, null);
        } else if (vehicle.getCurrentMeterReading() < 0) {
            return new CommonResponseModel("Invalid Meter Reading", false, null);
        } else if (vehicle.getPricePerDay()<0 || vehicle.getPricePerDay()>1000000) {
            return new CommonResponseModel("Invalid Price Per Day", false, null);
        }else if (vehicle.getPricePerKm()<0 || vehicle.getPricePerKm()>10000) {
            return new CommonResponseModel("Invalid Price Per KM", false, null);
        } else if (vehicle.getPricePerExtraKm()<0 || vehicle.getPricePerExtraKm()>10000) {
            return new CommonResponseModel("Invalid Price Per Extra KM", false, null);
        }else if (vehicle.getPricePerExtraHour()<0 || vehicle.getPricePerExtraHour()>10000) {
            return new CommonResponseModel("Invalid Price Per Extra Hour", false, null);
        }else {
            try {
                connection = DBConnectionFactory.getConnection();
                connection.setAutoCommit(false);
                int vehicleId = vehicleDao.insertVehicle(vehicle);
                vehicle.setVehicleId(vehicleId);
                vehicleDao.insertVehicleImages(vehicleId, imagePaths);
                connection.commit();
                return new CommonResponseModel("Vehicle Created Successfully!", true, null);
            } catch (SQLException e) {
                if (connection != null) {
                    connection.rollback();
                }
            }
            return new CommonResponseModel("Something went wrong!", false, null);
        }
    }
    public List<Vehicle> getAllVehicles() {
        return vehicleDao.getVehicles();
    }
    public List<Vehicle> getAllAvailableVehicles() {
        return vehicleDao.getAvailableVehicles();
    }
}
