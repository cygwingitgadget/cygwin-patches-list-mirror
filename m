From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] w32api - fix typo for InterlockedExchangePointer
Date: Tue, 04 Sep 2001 11:39:00 -0000
Message-id: <20010904143957.B9384@redhat.com>
X-SW-Source: 2001-q3/msg00102.html

Oops.  Wrong list.

----- Forwarded message from Christopher Faylor <cgf@redhat.com> -----

From: Christopher Faylor <cgf@redhat.com>
To: cygwin-developers@cygwin.com
Subject: [PATCH] w32api - fix typo for InterlockedExchangePointer
Date: Tue, 4 Sep 2001 14:22:16 -0400
Reply-To: cygwin-developers@cygwin.com
Mail-Followup-To: cygwin-developers@cygwin.com

Tue Sep  4 14:15:59 2001  Christopher Faylor <cgf@cygnus.com>

	* winbase.h: Add missing closing parentheses to
	InterlockedExchangePointer declaration.

Index: include/winbase.h
===================================================================
RCS file: /cvs/uberbaum/winsup/w32api/include/winbase.h,v
retrieving revision 1.14
diff -p -r1.14 winbase.h
*** winbase.h	2001/08/21 13:58:51	1.14
--- winbase.h	2001/09/04 18:15:48
*************** LONG WINAPI InterlockedDecrement(LPLONG)
*** 1319,1325 ****
  LONG WINAPI InterlockedExchange(LPLONG,LONG);
  /* PVOID WINAPI InterlockedExchangePointer(PVOID*,PVOID); */
  #define InterlockedExchangePointer(t,v) \
!     (PVOID)InterlockedExchange((LPLONG)(t),(LONG)(v)
  LONG WINAPI InterlockedExchangeAdd(PLONG,LONG);
  LONG WINAPI InterlockedIncrement(LPLONG);
  BOOL WINAPI IsBadCodePtr(FARPROC);
--- 1319,1325 ----
  LONG WINAPI InterlockedExchange(LPLONG,LONG);
  /* PVOID WINAPI InterlockedExchangePointer(PVOID*,PVOID); */
  #define InterlockedExchangePointer(t,v) \
!     (PVOID)InterlockedExchange((LPLONG)(t),(LONG)(v))
  LONG WINAPI InterlockedExchangeAdd(PLONG,LONG);
  LONG WINAPI InterlockedIncrement(LPLONG);
  BOOL WINAPI IsBadCodePtr(FARPROC);

----- End forwarded message -----
