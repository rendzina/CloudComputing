<!DOCTYPE html>
<html lang="en">
<head>
    <title>Cloud Computing - SQL Server Test Page</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <div class="container mt-4">
        <h1 class="mb-4">SQL Server Connection Test</h1>
        
        <?php
        // Database configuration
        $serverName = "tcp:<<DATABASE SERVER NAME>>.database.windows.net,1433";
        $connectionInfo = [
            "UID" => "<<DATABASE SERVER NAME>>",
            "pwd" => "<<PASSWORD>>",
            "Database" => "<<DATABASE NAME>>"
        ];

        try {
            // Establish connection
            $conn = sqlsrv_connect($serverName, $connectionInfo);
            
            if ($conn === false) {
                throw new Exception("Connection failed: " . print_r(sqlsrv_errors(), true));
            }

            // SQL query
            $tsql = "SELECT TOP 20 
                        pc.Name as CategoryName, 
                        p.name as ProductName
                    FROM [SalesLT].[ProductCategory] pc
                    JOIN [SalesLT].[Product] p
                        ON pc.productcategoryid = p.productcategoryid";

            // Execute query
            $getResults = sqlsrv_query($conn, $tsql);
            
            if ($getResults === false) {
                throw new Exception("Query failed: " . print_r(sqlsrv_errors(), true));
            }

            // Display results
            ?>
            <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <thead class="table-dark">
                        <tr>
                            <th>Category Name</th>
                            <th>Product Name</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        while ($row = sqlsrv_fetch_array($getResults, SQLSRV_FETCH_ASSOC)) {
                            echo "<tr>";
                            echo "<td>" . htmlspecialchars($row['CategoryName']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['ProductName']) . "</td>";
                            echo "</tr>";
                        }
                        ?>
                    </tbody>
                </table>
            </div>

            <div class="alert alert-success mt-3">
                <strong>Success!</strong> Data retrieved successfully.
            </div>
            <?php

            // Clean up
            sqlsrv_free_stmt($getResults);
            sqlsrv_close($conn);

        } catch (Exception $e) {
            ?>
            <div class="alert alert-danger">
                <strong>Error!</strong> <?php echo htmlspecialchars($e->getMessage()); ?>
            </div>
            <?php
        }
        ?>
    </div>
</body>
</html>
