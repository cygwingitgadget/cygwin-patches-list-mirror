From: Corinna Vinschen <vinschen@cygnus.com>
To: cygpatch <cygwin-patches@sources.redhat.com>
Subject: New files and changes in w32api
Date: Mon, 02 Oct 2000 02:38:00 -0000
Message-id: <39D8578A.DC1EE8F7@cygnus.com>
X-SW-Source: 2000-q4/msg00000.html

Hi,

I have added some stuff to w32api:

When implementing /dev/mem for NT/W2K one needs access to the native
NT API. The corresponding header is fragmentary:

- include/ntdef.h

All other new files and changes are by-products of investigating
the Win32 APIs "Internet Protocol Helper" and "RAS/Remote Access".

The Internet Protocol Helper suite is introduced with Win98 and
NT4 SP4. The headers and the library stub are complete from the
Win98/NT4SP4 point of view (I hope). New functions and types
introduced with W2K/ME are not part of those new files for now:

- lib/iphlpapi.def
- include/ipifcons.h
- include/iphlpapi.h
- include/iptypes.h
- include/iprtrmib.h
- include/ipexport.h

To get more information about the RAS interfaces I tried using
RasEnumDevices(). Not that helpful for me but no reason to throwaway.
So, that's new:

- lib/rasapi32.def: Add symbols for RasEnumDevicesA and RasEnumDevicesW.
- include/ras.h:    Fragmentary new header, currently only containing
                    the stuff needed for RasEnumDevices.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                        mailto:cygwin@sources.redhat.com
Red Hat, Inc.
mailto:vinschen@cygnus.com
