From: DJ Delorie <dj@delorie.com>
To: bkeener@thesoftwaresource.com
Cc: cygwin-patches@sources.redhat.com
Subject: Re: [patch] desktop.cc fix for icons and optional creation
Date: Wed, 06 Sep 2000 18:53:00 -0000
Message-id: <200009070153.VAA01509@envy.delorie.com>
References: <VA.000004dc.01b57bd2@thesoftwaresource.com>
X-SW-Source: 2000-q3/msg00070.html

Applied, with a number of minor typographic changes, including
properly formatting the ChangeLog entry.  Thanks!  I haven't uploaded
a new setup.exe; I have some other patches I want to add also, and
more testing to do.

See http://www.delorie.com/gnu/docs/GNU/standards_32.html

> 2000-09-05 Brian Keener    <bkeener@thesoftwaresource.com>
> 
>    * desktop.cc (desktop_icon) - correction to desktop directories
>      for desktop icon creation.  Additional logic added for Win95 which
>      does not appear to have Common Directories so if Common selected and 
>      null uses normal directory.
>    * desktop.cc (start_menu) - Additional logic added for Win95 which
>      does not appear to have Common Directories so if Common selected and
>      null uses normal directory.
>    * desktop.cc (do_desktop_setup) - moved the saving of the icon,
>      creation of the bat file, profile, passwd, Start Menu link and
>      desktop shortcut to this method from do_desktop.  Made the creation 
>      of the desktop icon and start menu link conditional on settings of 
>      new dialog created for desktop.
>    * desktop.cc - added logic to handle to the new dialog and to default
>      the setting for the new checkboxes based on whether the desktop icon 
>      or start menu link already exist.
>    * install.cc (do_install) - changed next from IDD_S_DESKTOP to
>      IDD_DESKTOP.
>    * main.cc (WinMain) - changed case IDD_S_DESKTOP to IDD_DESKTOP.
>    * res.rc - added new resource to create a desktop dialog with 2
>      checkboxes for creating the desktop icon and start menu link.
>    * resource.h - changed IDD_S_DESKTOP to IDD_DESKTOP and added two new
>      controls - IDC_ROOT_MENU and IDC_ROOT_DESKTOP for new dialog.
>    * state.h - added root_menu and root_desktop for use in dialog.
