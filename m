From: Brian Keener <bkeener@thesoftwaresource.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] setup.exe changes for Redownload/Reinstall Current version or Sources only - Part 2
Date: Wed, 09 May 2001 21:03:00 -0000
Message-id: <VA.0000075e.0034f511@thesoftwaresource.com>
References: <VA.00000757.0015edd1@thesoftwaresource.com> <20010508000842.A3591@redhat.com>
X-SW-Source: 2001-q2/msg00219.html

Christopher Faylor wrote:
> One problem that I had is that the installation of the sources
> ignored my mount setting for /usr/src and/or /src.  It extracted
> directly to (in my case) f:/cygwin/usr/src which made the extraction
> invisible to me, since /usr/src is mounted elsewhere.
> 
> I don't know if this is a new problem of if setup.exe has always
> worked like this, but this is a bug that could theoretically cause
> us problems.  Anyone want to look at this one?
>
Chris,

I don't think this is an original problem with setup and I found this 
recent change in the ChangeLog:

2001-03-10  Chris Abbey  <chris_abbey@yahoo.com>

        * install.cc: install sources into /usr/src instead
        of /, also include the sizes of source tarballs
        in total_bytes.
        * download.cc: include sizes of source tarballs in
        total_download_bytes.

I think I found the problem logic but only via quick look - I haven't 
really studied or stepped through yet.  In your last message you said:

> I don't care if the location is fixed, it should just honor the cygwin 
> mount table.

And I am not sure I know what you mean by this or how setup should work 
as a result.  Also Dr. Zell seems to have a similar problem with lib and 
bin and not sure what setup should do to deal with the mount points.

In install.cc (do_install) we have this code:

          int e = 0;
          if (package[i].action != ACTION_SRC_ONLY)
            e += install_one (package[i].name, pi.install, 
pi.install_size, pack
age[i].action, FALSE);
          if (package[i].srcaction == SRCACTION_YES && pi.source)
            e += install_one (concat (package[i].name, "-src", 0), 
pi.source, pi
source_size,
                              package[i].action, TRUE);


which does the install for either the source or binary package and then 
in (install_one) we have this code:

      dest_file = map_filename (fn, isSrc?"/usr/src":NULL);
      
      
which provides the extra path info for source files and then in 
(map_filename) we see:

char *
map_filename (char *fn, const char *extra = 0)
{
  char *dest_file;
  char *root_dir_with_extra = concat (root_dir, extra, 0);
  while (*fn == '/' || *fn == '\\')
    fn++;
  if (strncmp (fn, "usr/bin/", 8) == 0)
    dest_file = concat (root_dir_with_extra, "/bin/", fn+8, 0);

As you can see we are adding on the extra path which is /usr/src when it 
is a source file and using this for the create path and then we do some 
additional checking with bin and then also further down (code not 
included here) for lib.

Pretty sure that extra is the new stuff for the source file which is 
referenced in the change log, but as I said - I am unclear how setup 
should (as you say) honor the mount point and thus what I need to do to 
fix.  If you could provide some additional clarification.

bk

