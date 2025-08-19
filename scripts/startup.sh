#!/bin/sh

function run()
{
	$@ &
}

function srun()
{
	HOME=/h/sandbox $@ &
}

srun thunderbird --headless
srun firefox
run vesktop --start-minimized
