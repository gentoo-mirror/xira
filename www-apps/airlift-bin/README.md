# Why is this -bin if it's FOSS?
Blame the way Go handles dependencies. I was not able to create a `go vendor` archive that wouldn't make Go shut up saying the following:
```
github.com/mitchellh/mapstructure@v1.1.2: is explicitly required in go.mod, but not marked as explicit in vendor/modules.txt.
```

<p style="text-align: center;"><i>~ Cargo is better. ~</i></p>
