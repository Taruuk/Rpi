sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

# Install Build Essentials & GIT
sudo apt-get install -y build-essential git

# Install Node.js via Package Manager & Add Package Source
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -  # Install NodeJS v7 is no longer supported
sudo apt-get install -y nodejs  # npm nodejs-legacy #(Installed with nodesource)

# Update Node Package Manager (NPM)
sudo npm install npm@latest -g

# Get Version info
echo "[NPM] ============"; which npm; npm -v;
echo "[NODE] ============"; which node; node -v

# Install Latest Release Version of CNCjs
sudo npm install -g cncjs@latest --unsafe-perm

# --- OR ----

# Install Specific Version of CNCjs
#sudo npm install -g cncjs@v1.9.0-beta.1 --unsafe-perm  # Installs Specific Version based on TAG

# Install PM2
sudo npm install -g pm2

# Setup PM2 Startup Script
# sudo pm2 startup  # To Start PM2 as root
pm2 startup  # To start PM2 as pi / current user
#[PM2] You have to run this command as root. Execute the following command:
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u pi --hp /home/pi

# Start CNCjs (on port 8000, /w Tinyweb mount point) with PM2
pm2 start $(which cncjs) -- --port 8000 -m /tinyweb:/home/pi/tinyweb

# Set current running apps to startup
pm2 save

# Get list of PM2 processes
pm2 list
