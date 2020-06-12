title 'Nginx base plan tests'

plan_name = input('plan_name', value: 'nginx')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"

control 'base-plans-nginx-service' do
    impact 1.0
    title 'Ensure Nginx is running as a service'
    desc ''

    # Get the ident of the package
    status_cmd = command("hab svc status #{plan_ident}")
    svc_status = status_cmd.stdout.strip.split(/\s+/)

    # Test that the service is running
    # Ideally this should test the type, desired and state - however
    # as only running as a command this is not easy as we have to test the stdout
    # Using the habitat_service profile might be possible but that does not seem to work against a Docker image
    describe status_cmd do
        its('exit_status') { should eq 0 }
        its('stdout') { should_not be_empty }
    end
end