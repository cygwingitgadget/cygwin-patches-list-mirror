From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygcheck patch (updated)
Date: Fri, 15 Dec 2000 20:53:00 -0000
Message-id: <20001215235325.A13209@redhat.com>
References: <Pine.NEB.4.10.10012071044320.23344-101000@cesium.clock.org>
X-SW-Source: 2000-q4/msg00050.html

I was getting ready to check this in but, on inspection, there were some
problems with it.  The most minor was that the ChangeLog was not really
standard.  It shouldn't have white space between the functions, and the
tense should be present tense:

2000-12-07  Matt Hargett  <matt@use.net>

        * utils/cygcheck.cc (keyeprint): Move declaration before other
        functions so it could be used by all functions to report error
        messages. Add comment.
        (add_path): Check initial uses of pointers for NULL.
        (find_on_path): Ditto.
        (rva_to_offset): Ditto.
        (init_paths): Add checking for return values of Win32 calls.
        (get_dword): Ditto.
        (get_word): Ditto.
        (dll_info): Ditto, also add NULL pointer checks.
        (scan_registry): Ditto.
        (check_keys): Ditto.
        (dump_sysinfo): Ditto. Add default case to switch. Add error
        reporting if GetVolumeInformation fails, except when it
        returns ERROR_NOT_READY.
        (track_down): Add checking for NULL pointers and
        return values of Win32 calls.
	(cygwin_info): Correct small memory leak.

Other minor problems:

- if (0 == foo)

  rather than

  if (foo == 0)

- return (0);

  rather than

  return 0;

- Gratuitous reformatting of at least one section of code,
  along with an unneeded TODO.

- Unneeded checking for NULL pointers passed to some functions.

I've fixed all of the above and checked in your patch.

I appreciate the work that you put into this but I would also appreciate
it if you would keep the above observations in mind when you submit future
patches.

Thanks,
cgf

On Thu, Dec 14, 2000 at 10:25:27PM -0800, Matt wrote:
>I forgot to mention that I tested this on both Win98 and NT4, gcov
>reported 80% code coverage with my test cases. I ran the test cases on the
>old version and the new version, comparing the output (which was the same,
>save the timestamp printed and the path to the executable). The timings
>(using time) is about the same.
>
>Test cases were:
>1. cygcheck (no args)
>2. cygcheck -h -v -s -r
>3. cygcheck -v -h -k (press lotsa keys, then q)
>
>
>Changelog:
>
>2000-12-07  Matt Hargett  <matt@use.net>
>
>	* utils/cygcheck.cc (keyeprint): Moved declaration before other
>	functions so it could be used by all functions to report error
>	messages. Added comment.
>
>	(add_path): Initial uses of pointers are now checked for
>	NULL. This includes pointers from malloc() and pointers 
> 	passed as parameters.
>
>	(find_on_path): Ditto.
>
>	(rva_to_offset): Ditto.
>
>	(init_paths): Added checking for return values of Win32 calls.
>
>	(get_dword): Ditto.
>
>	(get_word): Ditto.
>
>	(dll_info): Ditto, also NULL pointer checks.
>
>	(scan_registry): Ditto.
>
>	(check_keys): Ditto.
>
>        (dump_sysinfo): Ditto. Added default case to switch. Added error
>	reporting if GetVolumeInformation fails, except when it
>	returns ERROR_NOT_READY. ERROR_NOT_READY is returned when
>	removeable drives are empty.
>
>	(track_down): Added checking for NULL pointers and 
>	return values of Win32 calls. Corrected small memory leak.
>



-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
