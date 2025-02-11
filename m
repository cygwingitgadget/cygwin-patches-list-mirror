Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CFA1A3858D1E; Tue, 11 Feb 2025 10:35:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CFA1A3858D1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1739270114;
	bh=tIcK9JVlxJSiAhuWqZ8JilxliSW2gnLS/MGC6/AubHI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=vAWrH16ANGvVdcNAenWWm4vjBHdRPdXljPN0UZWHRXF0eZ6icFCZm7LNFlOOQ+Gmr
	 iMr13Tlp33gcee5m5O8qRymF6EcPgbnxwTwW5bKTI90SqL01KBp/dDzz+uUEsVbMRM
	 byD9gzyt+mcXOcS+uSc1bYf/yhoxR46VA0P6enGE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 80D40A80D4C; Tue, 11 Feb 2025 11:35:12 +0100 (CET)
Date: Tue, 11 Feb 2025 11:35:12 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Subject: [PATCH v2 2/2] Cygwin: expose all windows volume mount
 points.
Message-ID: <Z6sn4M69vg32kp6s@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <156c9368-5e48-b426-0486-6987cdbf4311@jdrake.com>
 <ce78e46f-4f7e-f9f5-9f24-640bf0e63046@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce78e46f-4f7e-f9f5-9f24-640bf0e63046@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Feb 10 20:16, Jeremy Drake via Cygwin-patches wrote:
> Realized an oversight (besides the messed-up subject!) after sending:
> 
> > @@ -1943,14 +1961,6 @@ extern "C" FILE *
> >  setmntent (const char *filep, const char *)
> >  {
> >    _my_tls.locals.iteration = 0;
> > -  _my_tls.locals.available_drives = GetLogicalDrives ();
> > -  /* Filter floppy drives on A: and B: */
> > -  if ((_my_tls.locals.available_drives & 1)
> > -      && get_disk_type (L"A:") == DT_FLOPPY)
> > -    _my_tls.locals.available_drives &= ~1;
> > -  if ((_my_tls.locals.available_drives & 2)
> > -      && get_disk_type (L"B:") == DT_FLOPPY)
> > -    _my_tls.locals.available_drives &= ~2;
> 
> should have something like
> +  if (_my_tls.locals.drivemappings)
> +    {
> +      delete _my_tls.locals.drivemappings;
> +      _my_tls.locals.drivemappings = NULL;
> +    }
> here

Careful.

Consider _my_tls.locals.drivemappings being NULL, and then a thread
running the below code, indifferent to sense or use-case:

  getmntent ()

    if (!_my_tls.locals.drivemappings)
      _my_tls.locals.drivemappings = new dos_drive_mappings ();

    --> _my_tls.locals.drivemappings = 0x12345

  open ("/proc/self/mounts", O_RDONLY);

    format_process_mountstuff ()

      class dos_drive_mappings *drivemappings = _my_tls.locals.drivemappings;

      --> drivemappings = 0x12345

      setmntent ()

        delete _my_tls.locals.drivemappings;

        --> deletes 0x12345 !!!

        _my_tls.locals.drivemappings = NULL

      getmntent ()
          
        if (!_my_tls.locals.drivemappings)
          _my_tls.locals.drivemappings = new dos_drive_mappings ();

        --> _my_tls.locals.drivemappings = 0x98765;

      _my_tls.locals.drivemappings = drivemappings;

        --> _my_tls.locals.drivemappings = 0x12345 !!!

  getmntent ()

    --> SIGSEGV

I think format_process_mountstuff() should not call setmntent() at all,
but just swap _my_tls.locals.drivemappings with NULL.  Setting
_my_tls.locals.iteration is unnecessary as well in that case.

Compare:

   /* Store old value of _my_tls.locals here. */
-  int iteration = _my_tls.locals.iteration;
-  unsigned available_drives = _my_tls.locals.available_drives;
-  /* This reinitializes the above values in _my_tls. */
-  setmntent (NULL, NULL);
-  /* Restore iteration immediately since it's not used below.  We use the
-     local iteration variable instead*/
-  _my_tls.locals.iteration = iteration;
+  class dos_drive_mappings *drivemappings = _my_tls.locals.drivemappings;
+  _my_tls.locals.drivemappings = NULL;
 
   for (iteration = 0; (mnt = mtab->getmntent (iteration)); ++iteration)
     {

with:

   /* Store old value of _my_tls.locals here. */
   int iteration = _my_tls.locals.iteration;
-  unsigned available_drives = _my_tls.locals.available_drives;
+  class dos_drive_mappings *drivemappings = _my_tls.locals.drivemappings;
+  _my_tls.locals.drivemappings = NULL;
   /* This reinitializes the above values in _my_tls. */
   setmntent (NULL, NULL);
   /* Restore iteration immediately since it's not used below.  We use the


Thanks,
Corinna
