#!/bin/bash

aws backup start-restore-job --region us-west-1 --recovery-point-arn "arn:aws:backup:us-west-1:var.destination:recovery-point:bb5230b9-c61d-4a8f-9722-f6f4045d108a" --iam-role-arn "arn:aws:iam::var.destination:role/service-role/AWSBackupDefaultServiceRole" --metadata file://test.json --profile=dr-recovery
