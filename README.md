# xdebug-cookbook

Installs Xdebug PHP extension and reload the server for enable the configuration.

Example of debugging and profiling options are in [Common configuration options for vagrant][]

## Supported Platforms

 * Debian, Ubuntu

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['xdebug']['directives']</tt></td>
    <td>hash</td>
    <td>Hash of directives and values for `xdebug` configuration</td>
    <td><tt>{}</tt></td>
  </tr>
</table>

## Usage

### xdebug::install

Include `xdebug::install` in your node's `run_list` for install Xdebug extensions:


### xdebug::uninstall

Include `xdebug::uninstall` in your node's `run_list` for uninstall Xdebug extensions:


## Common configuration options for vagrant


```json
{
  "run_list": [
    "recipe[xdebug::install]"
  ],
  "default_attributes": {
    "xdebug": {
      "directives": {
        "remote_enable": "On",
        "remote_host": "192.168.33.1",
        "remote_port": "9000",
        "profiler_enable": "Off",
        "profiler_enable_trigger": "On",
        "profiler_output_dir": "/vagrant/xdebug",
        "auto_trace": "Off",
        "trace_enable_trigger": "On"
      }
    }
  }
}
```

`192.168.33.1` it's the IP of your workstation

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Startup Bootstrap
