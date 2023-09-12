<?php
header('Content-Type: application/json');
// Connect to DB
try {
    $con = new PDO('mysql:host=localhost;dbname=students_system', 'root', '', [PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES UTF8']);
    $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $con->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    // Store sessions
    session_id('sessionuserdata');
    session_start();
    // Response json object
    $response = [];
} catch (PDOException $e) {
    echo $e->getMessage();
}

// Logout after specific time
if (isset($_SESSION['logout_time']) && $_SESSION['logout_time'] < time()) {
    session_destroy();
}


// POST Actions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    //Login
    if ($_GET['action'] === 'login') {
        try {
            $username = trim($_POST['username']);
            $password = sha1($_POST['password']);
            // Search In DB
            $stmt = $con->prepare("SELECT `username`, `password`, `fullname`, `email`, `truststate` FROM `users` WHERE `username` = ? AND `password` = ?");
            $stmt->execute([$username, $password]);

            if ($stmt->rowCount()) {
                $response['login'] = true;
                // Store data in session
                $_SESSION['userdata'] = $stmt->fetch();
                $_SESSION['logout_time'] = time() + 60 * 60;
            } else {
                $response['login'] = false;
            }
        } catch (PDOException) {
            $response['login'] = 'Error';
        }
    }

    // Add Student
    if ($_GET['action'] === 'add_student') {
        try {
            $fullname = trim($_POST['fullname']);
            $phone = trim($_POST['phone']);
            $email = $_POST['email'];
            $state = $_POST['state'];

            $stmt = $con->prepare("INSERT INTO `students` (`id`, `fullname`, `phone`, `email`, `state`, `date`) VALUES (NULL, '$fullname', '$phone', '$email', '$state', current_timestamp());");
            $stmt->execute();

            $response['add_student'] = true;
        } catch (PDOException $e) {
            $response = end($e->errorInfo);
        }
    }

    // Edit Student
    if ($_GET['action'] === 'edit_student') {
        try {
            $id = trim($_POST['id']);
            $fullname = trim($_POST['fullname']);
            $phone = trim($_POST['phone']);
            $email = $_POST['email'];
            $state = $_POST['state'];
            $date = $_POST['date'];
            $stmt = $con->prepare("UPDATE `students` SET  `fullname` = '$fullname', `phone` = '$phone', `email` = '$email', `state` = '$state', `date` = '$date' WHERE `students`.`id` = '$id';");
            $stmt->execute();

            $response['edit_student'] = true;
        } catch (PDOException $e) {
            $response['edit_student'] = end($e->errorInfo);
        }
    }

    // Delete Student
    if ($_GET['action'] === 'delete_sdt') {
        try {
            $id = $_POST['id'];
            $stmt = $con->prepare("DELETE FROM `students` WHERE id = $id");
            $stmt->execute();
            $response['delete_sdt'] = true;
        } catch (PDOException $e) {
            $response['delete_sdt'] = $e->getMessage();
        }
    }
}


// GET Actions
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Delete All
    if ($_GET['action'] === 'deleteAll') {
        $stmt = $con->prepare('DELETE FROM students');
        $stmt->execute();
    }

    // Login Check
    if ($_GET['action'] === 'login_state') {
        if (isset($_SESSION['userdata'])) {
            $response['login_state'] = true;
        } else {
            session_destroy();
            $response['login_state'] = false;
        }
    }

    // Logout
    if ($_GET['action'] === 'logout') {
        session_destroy();
    }

    // Read All Students
    if ($_GET['action'] === 'read_students') {
        try {
            $stmt = $con->prepare('SELECT * FROM students ORDER BY `fullname`');
            $stmt->execute();

            $response['read_students'] = $stmt->fetchAll();
        } catch (PDOexception) {
            $response['read_students'] = false;
        }
    }

    // Read User Data
    if ($_GET['action'] === 'read_user') {
        $response['read_user'] = $_SESSION['userdata'];
    }

    // Read About info
    if ($_GET['action'] === 'read_about') {
        try {
            $stmt = $con->prepare('SELECT * FROM `about_app`');
            $stmt->execute();

            $response['read_about'] = $stmt->fetchAll();
        } catch (PDOexception) {
            $response['read_about'] = false;
        }
    }

}

// Return Response JSON Object
echo json_encode($response);

$con = null;