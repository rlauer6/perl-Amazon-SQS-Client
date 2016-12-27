# TESTING


Testing the module means making calls to AWS, which means you need an
AWS account and credentials.  Before testing specify your credentials
using environment variables as show below.

```
export AWS_ACCESS_KEY_ID=<your-access-key>
export AWS_SECRET_ACCESS_KEY=<your-secret-key>
```

There is currently only one test.  The test will list the queues for your
account. If you have no queues, the test should still work but will
not display any queues.

# TODO

Provide tests using the sample files provided in the original AWS .zip
file.
