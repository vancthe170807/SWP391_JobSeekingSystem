<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recruiter Job Posting</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .job-posting-container {
            margin-top: 50px;
            max-width: 900px;
            margin-left: auto;
            margin-right: auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            position: relative;
        }
        .job-posting-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .cancel-icon {
            font-size: 24px;
            color: red;
            cursor: pointer;
        }
        .btn-submit {
            background-color: #28a745;
            color: #fff;
            font-size: 18px;
        }
        .btn-submit:hover {
            background-color: #218838;
        }
        .btn-reset {
            background-color: #ffc107;
            color: #fff;
            font-size: 18px;
        }
        .btn-reset:hover {
            background-color: #e0a800;
        }
    </style>
</head>
<body>

<div class="container job-posting-container">
    <div class="job-posting-header">
        <h2 class="text-center">Post a Job</h2>
        <!-- Icon to cancel job posting -->
        <a href="javascript:void(0);" class="cancel-icon" onclick="window.location.href='recruiterHome.jsp'">
            <i class="fas fa-times-circle"></i>
        </a>
    </div>
    
    <form action="/submit-job-posting" method="POST">
        <!-- Job Title -->
        <div class="mb-3">
            <label for="title" class="form-label">Job Title</label>
            <input type="text" class="form-control" id="title" name="title" required>
        </div>
        
        <!-- Job Description -->
        <div class="mb-3">
            <label for="description" class="form-label">Job Description</label>
            <textarea class="form-control" id="description" name="description" rows="5" required></textarea>
        </div>
        
        <!-- Job Requirements -->
        <div class="mb-3">
            <label for="requirements" class="form-label">Job Requirements</label>
            <textarea class="form-control" id="requirements" name="requirements" rows="4" required></textarea>
        </div>
        
        <!-- Salary -->
        <div class="mb-3">
            <label for="salary" class="form-label">Salary (USD)</label>
            <input type="number" class="form-control" id="salary" name="salary" step="0.01" required>
        </div>
        
        <!-- Location -->
        <div class="mb-3">
            <label for="location" class="form-label">Job Location</label>
            <input type="text" class="form-control" id="location" name="location" required>
        </div>

        <!-- CompanyID dropdown -->
        <div class="mb-3">
            <label for="companyID" class="form-label">Company</label>
            <select class="form-select" id="companyID" name="companyID" required>
                <option value="">Select a Company</option>
                <option value="1">Company A</option>
                <option value="2">Company B</option>
                <option value="3">Company C</option>
            </select>
        </div>
        
        <!-- Posted Date -->
        <div class="mb-3">
            <label for="postedDate" class="form-label">Post Date</label>
            <input type="date" class="form-control" id="postedDate" name="postedDate" required>
        </div>

        <!-- Closing Date -->
        <div class="mb-3">
            <label for="closingDate" class="form-label">Closing Date</label>
            <input type="date" class="form-control" id="closingDate" name="closingDate" required>
        </div>

        <!-- Job Status dropdown -->
        <div class="mb-3">
            <label for="status" class="form-label">Job Status</label>
            <select class="form-select" id="status" name="status" required>
                <option value="open">Open</option>
                <option value="filled">Filled</option>
                <option value="closed">Closed</option>
            </select>
        </div>
        
        <!-- Submit and Reset buttons -->
        <div class="d-grid gap-2">
            <button type="submit" class="btn btn-submit">Submit Job Posting</button>
            <button type="reset" class="btn btn-reset">Reset Form</button>
        </div>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
