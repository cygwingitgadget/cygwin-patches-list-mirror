From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Add MAPISendMail to w32api
Date: Tue, 22 May 2001 16:04:00 -0000
Message-id: <20010522190240.A25370@redhat.com>
X-SW-Source: 2001-q2/msg00261.html

Tue May 22 18:58:27 2001  Christopher Faylor <cgf@cygnus.com>

	* lib/mapi32.def: Add MAPISendMail.
  
Index: lib/mapi32.def
===================================================================
RCS file: /cvs/uberbaum/winsup/w32api/lib/mapi32.def,v
retrieving revision 1.1.1.1
diff -p -r1.1.1.1 mapi32.def
*** mapi32.def	2000/02/17 19:38:32	1.1.1.1
--- mapi32.def	2001/05/22 23:01:21
*************** MAPIOpenFormMgr
*** 84,89 ****
--- 84,91 ----
  MAPIOpenFormMgr@8
  MAPIOpenLocalFormContainer
  MAPIOpenLocalFormContainer@4
+ MAPISendMail
+ MAPISendMail@20
  MAPIUninitialize
  MAPIUninitialize@0
  MNLS_CompareStringW@24
