From: Matt <matt@use.net>
To: cygwin-patches@sources.redhat.com
Subject: cygcheck patch (updated)
Date: Thu, 14 Dec 2000 22:25:00 -0000
Message-id: <Pine.NEB.4.10.10012071044320.23344-101000@cesium.clock.org>
X-SW-Source: 2000-q4/msg00047.html
Content-type: multipart/mixed; boundary="----------=_1583532846-65437-22"

This is a multi-part message in MIME format...

------------=_1583532846-65437-22
Content-length: 1375

I forgot to mention that I tested this on both Win98 and NT4, gcov
reported 80% code coverage with my test cases. I ran the test cases on the
old version and the new version, comparing the output (which was the same,
save the timestamp printed and the path to the executable). The timings
(using time) is about the same.

Test cases were:
1. cygcheck (no args)
2. cygcheck -h -v -s -r
3. cygcheck -v -h -k (press lotsa keys, then q)


Changelog:

2000-12-07  Matt Hargett  <matt@use.net>

	* utils/cygcheck.cc (keyeprint): Moved declaration before other
	functions so it could be used by all functions to report error
	messages. Added comment.

	(add_path): Initial uses of pointers are now checked for
	NULL. This includes pointers from malloc() and pointers 
 	passed as parameters.

	(find_on_path): Ditto.

	(rva_to_offset): Ditto.

	(init_paths): Added checking for return values of Win32 calls.

	(get_dword): Ditto.

	(get_word): Ditto.

	(dll_info): Ditto, also NULL pointer checks.

	(scan_registry): Ditto.

	(check_keys): Ditto.

        (dump_sysinfo): Ditto. Added default case to switch. Added error
	reporting if GetVolumeInformation fails, except when it
	returns ERROR_NOT_READY. ERROR_NOT_READY is returned when
	removeable drives are empty.

	(track_down): Added checking for NULL pointers and 
	return values of Win32 calls. Corrected small memory leak.


------------=_1583532846-65437-22
Content-Type: application/x-gzip; charset=binary; name="cygcheck.cc-patch.gz"
Content-Disposition: inline; filename="cygcheck.cc-patch.gz"
Content-Transfer-Encoding: base64
Content-Length: 5669

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

------------=_1583532846-65437-22--
