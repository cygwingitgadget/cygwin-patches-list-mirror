From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: Re: [Patch]  setup.exe changes to choose.cc for src files in choose list that shouldn't be
Date: Fri, 16 Mar 2001 20:45:00 -0000
Message-id: <20010316234559.A4725@redhat.com>
References: <VA.000006df.01efa247@thesoftwaresource.com>
X-SW-Source: 2001-q1/msg00192.html

On Fri, Mar 16, 2001 at 11:32:27PM -0500, Brian Keener wrote:
>Here are the changes to correct the Source files being listed in the
>current and version selection in choose.cc that Christopher Faylor
>reported.
>
>Also included is a change to allow the Checkbox for downloading the
>Source files when in Download mode to function as it should as reported
>by several people.  No we still don't have the one to allow us to
>re-download or re-install he current package or source files but it's
>on the list.
>
>Also a change to the network file function for proper file size
>handling.  Hope these help.
>
>2001-03-16  Brian Keener <bkeener@thesoftwaresource.com>
>
>   * nio-file.cc (NetIO_File::NetIO_File (char *Purl) : NetIO (Purl)): 
>   Use `get_file_size' instead of `stat'.
>   * choose.cc (list_click): Correct inability to select source code
>   for download.
>   (scan2): Modify to skip source tarballs when scanning disk for
>   installable packages.

Applied.  Thanks.

cgf
