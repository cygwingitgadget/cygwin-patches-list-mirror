From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: Re: [patch] setup.exe geturl.cc enhancement for total and diskfull download progress meters
Date: Tue, 27 Feb 2001 04:28:00 -0000
Message-id: <20010227132847.H27406@cygbert.vinschen.de>
References: <VA.00000670.003b71c8@thesoftwaresource.com>
X-SW-Source: 2001-q1/msg00121.html

On Tue, Feb 20, 2001 at 10:23:40PM -0500, Brian Keener wrote:
> 2001-02-20  Brian Keener <bkeener@thesoftwaresource.com>
>    * download.cc (do_download): New variables total_download_bytes and 
>    total_download_bytes_sofar added for download progress meter.  Add loop
>    to accumulate the total bytes to download from the selected packages.
>    * geturl.cc: Add state.h and diskfull.h to include list.  New variables
>    gw_iprogress, gw_pprogress, gw_progress_text, gw_pprogress_text, and
>    gw_iprogress_text added to allow for addition of Total packages download
>    progress meter and disk full percent progress meter.  Add variables
>    total_download_bytes and total_download_bytes_sofar for use by progress
>    meters.
>    (dialog_proc): New variables gw_iprogress, gw_pprogress, 
>    gw_progress_text, gw_pprogress_text, and gw_iprogress_text added to 
>    allow for addition of Total packages download progress meter and disk 
>    full percent progress meter.  
>    (init_dialog): Ditto.
>    (progress): Ditto.
>    (get_url_to_file): Ditto.
>    * geturl.h: Add external definition for total_download_bytes and
>    total_download_bytes_sofar.
>    * res.rc (): Add two additional progress meters (IDC_DLS_IPROGRESS) 
>         and (IDC_DLS_PPROGRESS) and three text objects (IDC_DLS_PROGRESS_TEXT)
>    and (IDC_DLS_IPROGRESS_TEXT, IDC_DLS_PPROGRESS_TEXT) for use in the
>    download meters.
>    * resource.h: Add new fields for progress meters and text and update 
>    _APS_NEXT_CONTROL_VALUE.
> [...]

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
