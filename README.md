# Notes

## This is just to test actions

To push to github container registry it appears that you need to set the registry and prefix to the image

To allow the push to occur you can use

```
username: ${{ github.actor}}
password: ${{ secrets.GITHUB_TOKEN }}
```

These values are set by github you do not need to set anything

For the action to be allowed to push you need to update a setting

https://github.com/couryrr/github-actions-experiments/settings/actions

There is a header Workflow permissions set the radio button to Read and Write Permissions
