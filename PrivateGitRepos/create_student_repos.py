'''
This script reads a csv file that includes student names and their GitHub accounts
For each student, it creates the GitHub repo, creates the directory structure, and pushes all changes.
'''
from github3 import login
import getpass
import subprocess
import csv
import os
import sys

def get_name(repository):
	return repository.name

def run():
    base = os.path.abspath(os.path.dirname(sys.argv[0]))
    username = 'karimhamdanali' # input('Enter your github username: ')
    organization = 'staticanalysisseminar' # input('Enter your github organization: ')
    github = login(username, password = getpass.getpass())
    memberships = github.organization_memberships()
    seminar = None

    for membership in memberships:
        if membership.organization.login == organization:
            seminar = membership.organization
            break

    existing_repos = set(map(get_name,seminar.iter_repos()))

    with open(base + os.path.sep + "StudentList.csv") as studentFile:
        reader = csv.DictReader(studentFile)
        for student in reader:
            repoName = "".join(student['Name'].split())
            if not repoName in existing_repos and len(student['GitHubUsername']) > 0:
                repository = seminar.create_repo(repoName, private=True)
                repository.add_collaborator(student['GitHubUsername'])
                subprocess.check_call([base + os.path.sep + "CreateRepoStructure.sh", organization, repoName])

run()