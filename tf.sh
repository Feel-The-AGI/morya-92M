#!/bin/bash

# Replace this with your actual personal access token
ACCESS_TOKEN="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"

# Your GitHub username
GITHUB_USERNAME="Feel-The-AGI"

# Navigate to the directory containing all your repos
cd /home/trainora/Downloads/tf || exit

# List of your repository names
repos=(
    "morya-92M"
)

for repo in "${repos[@]}"; do
    echo "Processing ${repo}..."
    # Check if the directory exists and is a Git repository
    if [ -d "$repo" ] && [ -d "$repo/.git" ]; then
        cd "$repo"
        # Initialize the repository if not already a Git repository
        git init
        # Add remote GitHub URL to your repository
        git remote add origin "https://$GITHUB_USERNAME:$ACCESS_TOKEN@github.com/$GITHUB_USERNAME/$repo.git"
        # Add all files to the repository
        git add .
        # Commit the added files
        git commit -m "Initial commit"
        # Push the repository to GitHub
        git push -u origin main
        echo "${repo} has been processed."
    else
        echo "Creating ${repo}..."
        # Create a new GitHub repository
        curl -u "$GITHUB_USERNAME:$ACCESS_TOKEN" https://api.github.com/user/repos -d "{\"name\":\"$repo\"}"
        # Initialize the local repository and push
        mkdir "$repo"
        cd "$repo"
        git init
        git remote add origin "https://$GITHUB_USERNAME:$ACCESS_TOKEN@github.com/$GITHUB_USERNAME/$repo.git"
        git add .
        git commit -m "Initial commit"
        git push -u origin main
        echo "${repo} created and pushed."
    fi
    # Go back to the repos directory before processing the next repository
    cd /home/trainora/Downloads/tf
done

echo "All repositories have been processed."
