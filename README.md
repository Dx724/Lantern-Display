# Dependencies
The following dependencies are used by the programs in this repository. It is possible that the programs will work with other versions, but it is ideal to maintain consistency with the tested environment.

# Run on boot
`systemd` is required to configure your Raspberry Pi to run these programs upon startup.
To set up the programs to run on boot, copy the files in the `services` directory to `/lib/systemd/system/`. If necessary, modify the files `lanterndisplay.service` and `stocklight.service` with a text editor to contain the appropriate paths to `python3`, `processing-java`, and the code files from this repository.
Have your system recognize the services with the command:
    sudo systemctl daemon-reload
Then, enable the services as follows:
    sudo systemctl enable lanterndisplay.service
    sudo systemctl enable stocklight.service
Upon restarting (e.g., `sudo reboot`), the programs should run.
