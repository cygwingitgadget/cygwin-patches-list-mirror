From: DJ Delorie <dj@delorie.com>
To: Andrej.Borsenkow@mow.siemens.ru
Cc: cygwin-patches@sources.redhat.com
Subject: Re: PATCH: setup.exe - local download directory selection dialog
Date: Wed, 06 Sep 2000 20:12:00 -0000
Message-id: <200009070311.XAA02103@envy.delorie.com>
References: <000c01c01358$6e7958b0$21c9ca95@mow.siemens.ru>
X-SW-Source: 2000-q3/msg00071.html

Applied, with a few minor changes.  Thanks!

> 2000-08-31  Andrej Borsenkow  <Andrej.Borsenkow@mow.siemens.ru>
>
> 	* localdir.cc: new, local package directory selection dialog;
> 	cd into selected directory
>
> 	* Makefile.in (OBJS): add localdir.o
> 	* dialog.h: add prototype for do_local_dir
> 	* main.cc. (WinMain): initialize local_dir to cwd;
> 	add call to do_local_dir
> 	* net.cc (dialog_cmd): make DO_LOCAL_DIR next dialog
> 	* source.cc (dialog_cmd): ditto
> 	* res.rc: add DO_LOCAL_DIR dialog;
> 	remove "current directory" from presented choices in IDD_SOURCE;
> 	add IDS_ERR_CHDIR error string
> 	* resource.h: defines for DO_LOCAL_DIR dialog; define IDS_ERR_CHDIR
> 	* root.cc (dialog_cmd): make DO_LOCAL_DIR previous dialog
> 	* state.h: add local_dir variable
