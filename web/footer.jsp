<%-- footer.jsp - Reusable Footer Component --%>
<footer class="main-footer">
    <div class="container-fluid">
        <div class="row align-items-center">
            <div class="col-md-6">
                <div class="footer-info">
                    <span class="text-muted">
                        © <%= java.time.Year.now().getValue() %> TaskFlow Management System. 
                        <strong>Version 2.1.0</strong>
                    </span>
                </div>
            </div>
            <div class="col-md-6 text-end">
                <div class="footer-links">
                    <a href="#" class="text-decoration-none me-3" data-bs-toggle="modal" data-bs-target="#helpModal">
                        <i class="fas fa-question-circle me-1"></i>Help
                    </a>
                    <a href="#" class="text-decoration-none me-3" data-bs-toggle="modal" data-bs-target="#aboutModal">
                        <i class="fas fa-info-circle me-1"></i>About
                    </a>
                    <a href="mailto:support@taskflow.com" class="text-decoration-none">
                        <i class="fas fa-envelope me-1"></i>Support
                    </a>
                </div>
            </div>
        </div>
        
        <div class="row mt-2">
            <div class="col-12">
                <div class="system-status d-flex align-items-center justify-content-between">
                    <div class="status-indicator">
                        <span class="status-dot status-online"></span>
                        <small class="text-muted">System Status: Online</small>
                    </div>
                    <div class="last-login">
                        <small class="text-muted">
                            <i class="fas fa-clock me-1"></i>
                            Last login: <%= new java.text.SimpleDateFormat("MMM dd, yyyy HH:mm").format(new java.util.Date()) %>
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>

<!-- Help Modal -->
<div class="modal fade" id="helpModal" tabindex="-1" aria-labelledby="helpModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="helpModalLabel">
                    <i class="fas fa-question-circle me-2"></i>Help & Documentation
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6">
                        <h6><i class="fas fa-tasks me-2"></i>Task Management</h6>
                        <ul class="list-unstyled">
                            <li><small>? Create and assign tasks to team members</small></li>
                            <li><small>? Track progress and deadlines</small></li>
                            <li><small>? Set priorities and categories</small></li>
                        </ul>
                    </div>
                    <div class="col-md-6">
                        <h6><i class="fas fa-project-diagram me-2"></i>Project Management</h6>
                        <ul class="list-unstyled">
                            <li><small>? Organize tasks by projects</small></li>
                            <li><small>? Monitor project timelines</small></li>
                            <li><small>? Generate project reports</small></li>
                        </ul>
                    </div>
                </div>
                <hr>
                <div class="text-center">
                    <a href="mailto:support@taskflow.com" class="btn btn-primary btn-sm">
                        <i class="fas fa-envelope me-2"></i>Contact Support
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- About Modal -->
<div class="modal fade" id="aboutModal" tabindex="-1" aria-labelledby="aboutModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="aboutModalLabel">
                    <i class="fas fa-info-circle me-2"></i>About TaskFlow
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center">
                <i class="fas fa-ticket-alt fa-4x text-primary mb-3"></i>
                <h4>TaskFlow Management System</h4>
                <p class="text-muted">Version 2.1.0</p>
                <p>A comprehensive task and project management solution designed to streamline workflows and enhance productivity.</p>
                <div class="d-flex justify-content-center mt-3">
                    <span class="badge bg-success me-2">
                        <i class="fas fa-check me-1"></i>Secure
                    </span>
                    <span class="badge bg-info me-2">
                        <i class="fas fa-cloud me-1"></i>Cloud-Ready
                    </span>
                    <span class="badge bg-warning">
                        <i class="fas fa-mobile-alt me-1"></i>Mobile-Friendly
                    </span>
                </div>
            </div>
        </div>
    </div>
</div>