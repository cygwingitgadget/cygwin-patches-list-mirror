Return-Path: <cygwin-patches-return-6369-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8035 invoked by alias); 3 Dec 2008 16:26:19 -0000
Received: (qmail 7974 invoked by uid 22791); 3 Dec 2008 16:26:17 -0000
X-Spam-Check-By: sourceware.org
Received: from vms044pub.verizon.net (HELO vms044pub.verizon.net) (206.46.252.44)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 03 Dec 2008 16:25:38 +0000
Received: from PHUMBLETLAPXP ([70.88.219.194])  by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006)) with ESMTPA id <0KBB00G466YG9OH0@vms044.mailsrvcs.net> for  cygwin-patches@cygwin.com; Wed, 03 Dec 2008 10:25:30 -0600 (CST)
Date: Wed, 03 Dec 2008 16:26:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch] Minires update
To: <cygwin-patches@cygwin.com>
Message-id: <00c701c95563$c4267df0$940410ac@wirelessworld.airvananet.com>
MIME-version: 1.0
Content-type: multipart/mixed;  boundary="----=_NextPart_000_00C4_01C95539.D9F3F330"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00013.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_00C4_01C95539.D9F3F330
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 9450

This patch syncs the built-in minires with the latest packaged version.
Also attaching the files to guarantee format preservation.

Pierre

2008-12-03  Pierre A. Humblet  <Pierre.Humblet@ieee.org>

        * libc/minires.c (open_sock): Set non blocking and close on exec.
        (res_ninit): Set id pseudo-randomly.
        (res_nsend): Do not set close on exec. Initialize server from id.
        Flush socket. Tighten rules for answer acceptance.
        (res_nmkquery): Update id using current data.

Index: minires.c
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/libc/minires.c,v
retrieving revision 1.4
diff -u -p -r1.4 minires.c
--- minires.c 1 Apr 2008 10:22:33 -0000 1.4
+++ minires.c 3 Dec 2008 02:57:26 -0000
@@ -1,6 +1,6 @@
 /* minires.c.  Stub synchronous resolver for Cygwin.
 
-   Copyright 2006 Red Hat, Inc.
+   Copyright 2008 Red Hat, Inc.
 
    Written by Pierre A. Humblet <Pierre.Humblet@ieee.org>
 
@@ -225,6 +225,17 @@ static int open_sock(struct sockaddr_in 
     DPRINTF(debug, "socket(UDP): %s\n", strerror(errno));
     return -1;
   }
+  /* Set non-blocking */
+  if (fcntl64(fd, F_SETFL, O_NONBLOCK) < 0)  {
+    DPRINTF(debug, "fcntl: %s\n", strerror(errno));
+    return -1;
+  }
+  /* Set close on exec flag */
+  if (fcntl64(fd, F_SETFD, 1) == -1) {
+    DPRINTF(debug, "fcntl: %s\n", strerror(errno));
+    return -1;
+  }
+
   CliAddr->sin_family = AF_INET;
   CliAddr->sin_addr.s_addr = htonl(INADDR_ANY);
   CliAddr->sin_port = htons(0);
@@ -266,7 +277,10 @@ int res_ninit(res_state statp)
   statp->use_os = 1;            /* use os_query if available and allowed by get_resolv */
   statp->mypid = -1;
   statp->sockfd = -1;
-
+  /* Use the pid and the ppid for random seed, from the point of view of an outsider.
+     Mix the upper and lower bits as they are not used equally */
+  i = getpid();
+  statp->id = (ushort) (getppid() ^ (i << 8) ^ (i >> 8));
   for (i = 0; i < DIM(statp->dnsrch); i++)  statp->dnsrch[i] = 0;
 
   /* resolv.conf (dns servers & search list)*/
@@ -420,22 +434,15 @@ int res_nsend( res_state statp, const un
 
   /* Open a socket for this process */
   if (statp->sockfd == -1) {
-    /* Create a socket and bind it (to any port) */
+    /* Create a non-blocking, close on exec socket and bind it (to any port) */
     statp->sockfd = open_sock(& mySockAddr, debug);
     if (statp->sockfd  < 0 ) {
       statp->res_h_errno = NETDB_INTERNAL;
       return -1;
     }
-    /* Set close on exec flag */
-    if (fcntl64(statp->sockfd, F_SETFD, 1) == -1) {
-      DPRINTF(debug, "fcntl: %s\n",
-       strerror(errno));
-      statp->res_h_errno = NETDB_INTERNAL;
-      return -1;
-    }
     statp->mypid = getpid();
     if (SServ == 0XFFFFFFFF) /* Pseudo random */
-      SServ =  statp->mypid % statp->nscount;
+      SServ =  statp->id % statp->nscount;
   }
 
   transNum = 0;
@@ -443,6 +450,26 @@ int res_nsend( res_state statp, const un
     if ((wServ = SServ + 1) >= statp->nscount)
       wServ = 0;
     SServ = wServ;
+
+    /* There exists attacks on DNS where many wrong answers with guessed id's and
+       spoofed source address and port are generated at about the time when the
+       program is tricked into resolving a name.
+       This routine runs through the retry loop for each incorrect answer.
+       It is thus extremely likely that such attacks will cause a TRY_AGAIN return,
+       probably causing the calling program to retry after a delay.
+       
+       Note that valid late or duplicate answers to a previous questions also cause
+       a retry, although this is minimized by flushing the socket before sending the
+       new question.
+    */
+
+    /* Flush duplicate or late answers */
+    while ((rslt = cygwin_recvfrom( statp->sockfd, AnsPtr, AnsLength, 0, NULL, NULL)) >= 0) {
+      DPRINTF(debug, "Flushed %d bytes\n", rslt);
+    }
+    DPRINTF(debug && (errno != EWOULDBLOCK), 
+     "Unexpected errno for flushing recvfrom: %s", strerror(errno)); 
+
     /* Send the message */
     rslt = cygwin_sendto(statp->sockfd, MsgPtr, MsgLength, 0,
     (struct sockaddr *) &statp->nsaddr_list[wServ],
@@ -481,59 +508,66 @@ int res_nsend( res_state statp, const un
       statp->res_h_errno = NETDB_INTERNAL;
       return -1;
     }
-    /*
-       Prepare to retry with tcp
+    DPRINTF(debug, "recvfrom: %d bytes from %08x\n", rslt, dnsSockAddr.sin_addr.s_addr);
+    /* 
+       Prepare to retry with tcp 
     */
     for (tcp = 0; tcp < 2; tcp++) {
-      /* Check if this is the message we expected */
-      if ((*MsgPtr == *AnsPtr)     /* Ids match */
-   && (*(MsgPtr + 1) == *(AnsPtr + 1))
-/* We have stopped checking this because the question may not be present on error,
-   in particular when the name in the question is not a valid name.
-   Simply check that the header is present. */
+      /* Check if this is the expected message from the expected server */
+      if ((memcmp(& dnsSockAddr, & statp->nsaddr_list[wServ],
+    (char *) & dnsSockAddr.sin_zero[0] - (char *) & dnsSockAddr) == 0)
    && (rslt >= HFIXEDSZ)
-/*        && (rslt >= MsgLength )
-   && (memcmp(MsgPtr + HFIXEDSZ, AnsPtr + HFIXEDSZ, MsgLength - HFIXEDSZ) == 0) */
-   && ((AnsPtr[2] & QR) != 0)) {
-
- DPRINTF(debug, "answer %u from %08x. Error %d. Count %d.\n",
-  rslt, dnsSockAddr.sin_addr.s_addr,
-  AnsPtr[3] & ERR_MASK, AnsPtr[6]*256 + AnsPtr[7]);
-#if 0
- NETDB_INTERNAL -1 /* see errno */
- NETDB_SUCCESS   0 /* no problem */
- HOST_NOT_FOUND  1 /* Authoritative Answer Host not found */
- TRY_AGAIN       2 /* Non-Authoritive Host not found, or SERVERFAIL */
-    Also seen returned by some servers when the name is too long
- NO_RECOVERY     3 /* Non recoverable errors, FORMERR, REFUSED, NOTIMP */
- NO_DATA         4 /* Valid name, no data record of requested type */
-#endif
+   && (*MsgPtr == *AnsPtr)     /* Ids match */
+   && (*(MsgPtr + 1) == *(AnsPtr + 1))
+   && ((AnsPtr[2] & QR) != 0)
+   && (AnsPtr[4] == 0)
+   /* We check the question if present.
+      Some servers don't return it on error, in particular
+      when the name in the question is not valid. */
+   && (((AnsPtr[5] == 0)
+        && ((AnsPtr[3] & ERR_MASK) != NOERROR))
+       || ((AnsPtr[5] == 1)
+    && (rslt >= MsgLength)
+    && (memcmp(MsgPtr + HFIXEDSZ, AnsPtr + HFIXEDSZ, MsgLength - HFIXEDSZ) == 0)))) {
  if ((AnsPtr[3] & ERR_MASK) == NOERROR) {
-   if ((AnsPtr[2] & TC) && !(statp->options & RES_IGNTC)) { /* Truncated. Try TCP */
+   if ((AnsPtr[2] & TC) && (tcp == 0) && !(statp->options & RES_IGNTC)) { 
+     /* Truncated. Try TCP */
      rslt = get_tcp(&statp->nsaddr_list[wServ], MsgPtr, MsgLength,
       AnsPtr, AnsLength, statp->options & RES_DEBUG);
-     continue;
+     continue /* Tcp loop */; 
    }
    else if ((AnsPtr[6] | AnsPtr[7])!= 0)
      return rslt;
    else
      statp->res_h_errno = NO_DATA;
  }
+#if 0
+ NETDB_INTERNAL -1 /* see errno */
+ NETDB_SUCCESS   0 /* no problem */
+ HOST_NOT_FOUND  1 /* Authoritative Answer Host not found */
+ TRY_AGAIN       2 /* Non-Authoritive Host not found, or SERVERFAIL */
+    Also seen returned by some servers when the name is too long
+ NO_RECOVERY     3 /* Non recoverable errors, FORMERR, REFUSED, NOTIMP */
+ NO_DATA         4 /* Valid name, no data record of requested type */
+#endif
  else {
+   switch (AnsPtr[3] & ERR_MASK) {
    /* return HOST_NOT_FOUND even for non-authoritative answers */
-   if ((AnsPtr[3] & ERR_MASK) == NXDOMAIN)
+   case NXDOMAIN:
+   case FORMERR:
      statp->res_h_errno = HOST_NOT_FOUND;
-   else if ((AnsPtr[3] & ERR_MASK) == SERVFAIL)
+     break;
+   case SERVFAIL: 
      statp->res_h_errno = TRY_AGAIN;
-   else
+     break;
+   default:
      statp->res_h_errno = NO_RECOVERY;
+   }
  }
  return -1;
       }
       else {
- DPRINTF(debug, "unexpected answer %u from %x to query to %x\n",
-  rslt, dnsSockAddr.sin_addr.s_addr,
-  statp->nsaddr_list[wServ].sin_addr.s_addr);
+ DPRINTF(debug, "unexpected answer\n");
  break;
       }
     } /* TCP */
@@ -564,7 +598,8 @@ int res_nmkquery (res_state statp,
     const unsigned char * newrr, unsigned char * buf, int buflen)
 {
   int i, len;
-  short id;
+  const char * ptr;
+  unsigned int id4;
 
   if (op == QUERY) {
     /* Write the name and verify buffer length */
@@ -575,10 +610,10 @@ int res_nmkquery (res_state statp,
       statp->res_h_errno = NETDB_INTERNAL;
       return -1;
     }
+
     /* Fill the header */
-    id = statp->id;
-    PUTSHORT(id, buf);
-    PUTSHORT(RD, buf);
+    PUTSHORT(statp->id, buf);
+    PUTSHORT(RD, buf); 
     PUTSHORT(1, buf); /* Number of questions */
     for (i = 0; i < 3; i++)
       PUTSHORT(0, buf); /* Number of answers */
@@ -587,7 +622,19 @@ int res_nmkquery (res_state statp,
     buf += len;
     PUTSHORT(qtype, buf);
     PUTSHORT(qclass, buf);
-    return len + 16; /* packet size */
+
+    /* Update id. The current query adds entropy to the next query id */
+    for (id4 = qtype, i = 0, ptr = dnameptr; *ptr; ptr++, i += 3) 
+      id4 ^= *ptr << (i & 0xF);
+    i = 1 + statp->id % 15; /* Between 1 and 16 */
+    /* id dependent rotation, also brings MSW to LSW */
+    id4 = (id4 << i) ^ (id4 >> (16 - i)) ^ (id4 >> (32 - i));
+    if ((short) id4)
+      statp->id ^= (short) id4;
+    else 
+      statp->id++; /* Force change */
+
+    return len + (HFIXEDSZ + QFIXEDSZ); /* packet size */
   }
   else { /* Not implemented */
     errno = ENOSYS;

------=_NextPart_000_00C4_01C95539.D9F3F330
Content-Type: application/octet-stream;
	name="minires.c.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="minires.c.diff"
Content-length: 10321

Index: minires.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/libc/minires.c,v=0A=
retrieving revision 1.4=0A=
diff -u -p -r1.4 minires.c=0A=
--- minires.c	1 Apr 2008 10:22:33 -0000	1.4=0A=
+++ minires.c	3 Dec 2008 02:57:26 -0000=0A=
@@ -1,6 +1,6 @@=0A=
 /* minires.c.  Stub synchronous resolver for Cygwin.=0A=
=20=0A=
-   Copyright 2006 Red Hat, Inc.=0A=
+   Copyright 2008 Red Hat, Inc.=0A=
=20=0A=
    Written by Pierre A. Humblet <Pierre.Humblet@ieee.org>=0A=
=20=0A=
@@ -225,6 +225,17 @@ static int open_sock(struct sockaddr_in=20=0A=
     DPRINTF(debug, "socket(UDP): %s\n", strerror(errno));=0A=
     return -1;=0A=
   }=0A=
+  /* Set non-blocking */=0A=
+  if (fcntl64(fd, F_SETFL, O_NONBLOCK) < 0)  {=0A=
+    DPRINTF(debug, "fcntl: %s\n", strerror(errno));=0A=
+    return -1;=0A=
+  }=0A=
+  /* Set close on exec flag */=0A=
+  if (fcntl64(fd, F_SETFD, 1) =3D=3D -1) {=0A=
+    DPRINTF(debug, "fcntl: %s\n", strerror(errno));=0A=
+    return -1;=0A=
+  }=0A=
+=0A=
   CliAddr->sin_family =3D AF_INET;=0A=
   CliAddr->sin_addr.s_addr =3D htonl(INADDR_ANY);=0A=
   CliAddr->sin_port =3D htons(0);=0A=
@@ -266,7 +277,10 @@ int res_ninit(res_state statp)=0A=
   statp->use_os =3D 1;            /* use os_query if available and allowed=
 by get_resolv */=0A=
   statp->mypid =3D -1;=0A=
   statp->sockfd =3D -1;=0A=
-=0A=
+  /* Use the pid and the ppid for random seed, from the point of view of a=
n outsider.=0A=
+     Mix the upper and lower bits as they are not used equally */=0A=
+  i =3D getpid();=0A=
+  statp->id =3D (ushort) (getppid() ^ (i << 8) ^ (i >> 8));=0A=
   for (i =3D 0; i < DIM(statp->dnsrch); i++)  statp->dnsrch[i] =3D 0;=0A=
=20=0A=
   /* resolv.conf (dns servers & search list)*/=0A=
@@ -420,22 +434,15 @@ int res_nsend( res_state statp, const un=0A=
=20=0A=
   /* Open a socket for this process */=0A=
   if (statp->sockfd =3D=3D -1) {=0A=
-    /* Create a socket and bind it (to any port) */=0A=
+    /* Create a non-blocking, close on exec socket and bind it (to any por=
t) */=0A=
     statp->sockfd =3D open_sock(& mySockAddr, debug);=0A=
     if (statp->sockfd  < 0 ) {=0A=
       statp->res_h_errno =3D NETDB_INTERNAL;=0A=
       return -1;=0A=
     }=0A=
-    /* Set close on exec flag */=0A=
-    if (fcntl64(statp->sockfd, F_SETFD, 1) =3D=3D -1) {=0A=
-      DPRINTF(debug, "fcntl: %s\n",=0A=
-	      strerror(errno));=0A=
-      statp->res_h_errno =3D NETDB_INTERNAL;=0A=
-      return -1;=0A=
-    }=0A=
     statp->mypid =3D getpid();=0A=
     if (SServ =3D=3D 0XFFFFFFFF) /* Pseudo random */=0A=
-      SServ =3D  statp->mypid % statp->nscount;=0A=
+      SServ =3D  statp->id % statp->nscount;=0A=
   }=0A=
=20=0A=
   transNum =3D 0;=0A=
@@ -443,6 +450,26 @@ int res_nsend( res_state statp, const un=0A=
     if ((wServ =3D SServ + 1) >=3D statp->nscount)=0A=
       wServ =3D 0;=0A=
     SServ =3D wServ;=0A=
+=0A=
+    /* There exists attacks on DNS where many wrong answers with guessed i=
d's and=0A=
+       spoofed source address and port are generated at about the time whe=
n the=0A=
+       program is tricked into resolving a name.=0A=
+       This routine runs through the retry loop for each incorrect answer.=
=0A=
+       It is thus extremely likely that such attacks will cause a TRY_AGAI=
N return,=0A=
+       probably causing the calling program to retry after a delay.=0A=
+=20=20=20=20=20=20=20=0A=
+       Note that valid late or duplicate answers to a previous questions a=
lso cause=0A=
+       a retry, although this is minimized by flushing the socket before s=
ending the=0A=
+       new question.=0A=
+    */=0A=
+=0A=
+    /* Flush duplicate or late answers */=0A=
+    while ((rslt =3D cygwin_recvfrom( statp->sockfd, AnsPtr, AnsLength, 0,=
 NULL, NULL)) >=3D 0) {=0A=
+      DPRINTF(debug, "Flushed %d bytes\n", rslt);=0A=
+    }=0A=
+    DPRINTF(debug && (errno !=3D EWOULDBLOCK),=20=0A=
+	    "Unexpected errno for flushing recvfrom: %s", strerror(errno));=20=0A=
+=0A=
     /* Send the message */=0A=
     rslt =3D cygwin_sendto(statp->sockfd, MsgPtr, MsgLength, 0,=0A=
 			 (struct sockaddr *) &statp->nsaddr_list[wServ],=0A=
@@ -481,59 +508,66 @@ int res_nsend( res_state statp, const un=0A=
       statp->res_h_errno =3D NETDB_INTERNAL;=0A=
       return -1;=0A=
     }=0A=
-    /*=0A=
-       Prepare to retry with tcp=0A=
+    DPRINTF(debug, "recvfrom: %d bytes from %08x\n", rslt, dnsSockAddr.sin=
_addr.s_addr);=0A=
+    /*=20=0A=
+       Prepare to retry with tcp=20=0A=
     */=0A=
     for (tcp =3D 0; tcp < 2; tcp++) {=0A=
-      /* Check if this is the message we expected */=0A=
-      if ((*MsgPtr =3D=3D *AnsPtr)     /* Ids match */=0A=
-	  && (*(MsgPtr + 1) =3D=3D *(AnsPtr + 1))=0A=
-/* We have stopped checking this because the question may not be present o=
n error,=0A=
-   in particular when the name in the question is not a valid name.=0A=
-   Simply check that the header is present. */=0A=
+      /* Check if this is the expected message from the expected server */=
=0A=
+      if ((memcmp(& dnsSockAddr, & statp->nsaddr_list[wServ],=0A=
+		  (char *) & dnsSockAddr.sin_zero[0] - (char *) & dnsSockAddr) =3D=3D 0)=
=0A=
 	  && (rslt >=3D HFIXEDSZ)=0A=
-/*        && (rslt >=3D MsgLength )=0A=
-	  && (memcmp(MsgPtr + HFIXEDSZ, AnsPtr + HFIXEDSZ, MsgLength - HFIXEDSZ) =
=3D=3D 0) */=0A=
-	  && ((AnsPtr[2] & QR) !=3D 0)) {=0A=
-=0A=
-	DPRINTF(debug, "answer %u from %08x. Error %d. Count %d.\n",=0A=
-		rslt, dnsSockAddr.sin_addr.s_addr,=0A=
-		AnsPtr[3] & ERR_MASK, AnsPtr[6]*256 + AnsPtr[7]);=0A=
-#if 0=0A=
- NETDB_INTERNAL -1 /* see errno */=0A=
- NETDB_SUCCESS   0 /* no problem */=0A=
- HOST_NOT_FOUND  1 /* Authoritative Answer Host not found */=0A=
- TRY_AGAIN       2 /* Non-Authoritive Host not found, or SERVERFAIL */=0A=
-			 Also seen returned by some servers when the name is too long=0A=
- NO_RECOVERY     3 /* Non recoverable errors, FORMERR, REFUSED, NOTIMP */=
=0A=
- NO_DATA         4 /* Valid name, no data record of requested type */=0A=
-#endif=0A=
+	  && (*MsgPtr =3D=3D *AnsPtr)     /* Ids match */=0A=
+	  && (*(MsgPtr + 1) =3D=3D *(AnsPtr + 1))=0A=
+	  && ((AnsPtr[2] & QR) !=3D 0)=0A=
+	  && (AnsPtr[4] =3D=3D 0)=0A=
+	  /* We check the question if present.=0A=
+	     Some servers don't return it on error, in particular=0A=
+	     when the name in the question is not valid. */=0A=
+	  && (((AnsPtr[5] =3D=3D 0)=0A=
+	       && ((AnsPtr[3] & ERR_MASK) !=3D NOERROR))=0A=
+	      || ((AnsPtr[5] =3D=3D 1)=0A=
+		  && (rslt >=3D MsgLength)=0A=
+		  && (memcmp(MsgPtr + HFIXEDSZ, AnsPtr + HFIXEDSZ, MsgLength - HFIXEDSZ)=
 =3D=3D 0)))) {=0A=
 	if ((AnsPtr[3] & ERR_MASK) =3D=3D NOERROR) {=0A=
-	  if ((AnsPtr[2] & TC) && !(statp->options & RES_IGNTC)) { /* Truncated. =
Try TCP */=0A=
+	  if ((AnsPtr[2] & TC) && (tcp =3D=3D 0) && !(statp->options & RES_IGNTC)=
) {=20=0A=
+	    /* Truncated. Try TCP */=0A=
 	    rslt =3D get_tcp(&statp->nsaddr_list[wServ], MsgPtr, MsgLength,=0A=
 			   AnsPtr, AnsLength, statp->options & RES_DEBUG);=0A=
-	    continue;=0A=
+	    continue /* Tcp loop */;=20=0A=
 	  }=0A=
 	  else if ((AnsPtr[6] | AnsPtr[7])!=3D 0)=0A=
 	    return rslt;=0A=
 	  else=0A=
 	    statp->res_h_errno =3D NO_DATA;=0A=
 	}=0A=
+#if 0=0A=
+ NETDB_INTERNAL -1 /* see errno */=0A=
+ NETDB_SUCCESS   0 /* no problem */=0A=
+ HOST_NOT_FOUND  1 /* Authoritative Answer Host not found */=0A=
+ TRY_AGAIN       2 /* Non-Authoritive Host not found, or SERVERFAIL */=0A=
+			 Also seen returned by some servers when the name is too long=0A=
+ NO_RECOVERY     3 /* Non recoverable errors, FORMERR, REFUSED, NOTIMP */=
=0A=
+ NO_DATA         4 /* Valid name, no data record of requested type */=0A=
+#endif=0A=
 	else {=0A=
+	  switch (AnsPtr[3] & ERR_MASK) {=0A=
 	  /* return HOST_NOT_FOUND even for non-authoritative answers */=0A=
-	  if ((AnsPtr[3] & ERR_MASK) =3D=3D NXDOMAIN)=0A=
+	  case NXDOMAIN:=0A=
+	  case FORMERR:=0A=
 	    statp->res_h_errno =3D HOST_NOT_FOUND;=0A=
-	  else if ((AnsPtr[3] & ERR_MASK) =3D=3D SERVFAIL)=0A=
+	    break;=0A=
+	  case SERVFAIL:=20=0A=
 	    statp->res_h_errno =3D TRY_AGAIN;=0A=
-	  else=0A=
+	    break;=0A=
+	  default:=0A=
 	    statp->res_h_errno =3D NO_RECOVERY;=0A=
+	  }=0A=
 	}=0A=
 	return -1;=0A=
       }=0A=
       else {=0A=
-	DPRINTF(debug, "unexpected answer %u from %x to query to %x\n",=0A=
-		rslt, dnsSockAddr.sin_addr.s_addr,=0A=
-		statp->nsaddr_list[wServ].sin_addr.s_addr);=0A=
+	DPRINTF(debug, "unexpected answer\n");=0A=
 	break;=0A=
       }=0A=
     } /* TCP */=0A=
@@ -564,7 +598,8 @@ int res_nmkquery (res_state statp,=0A=
 		  const unsigned char * newrr, unsigned char * buf, int buflen)=0A=
 {=0A=
   int i, len;=0A=
-  short id;=0A=
+  const char * ptr;=0A=
+  unsigned int id4;=0A=
=20=0A=
   if (op =3D=3D QUERY) {=0A=
     /* Write the name and verify buffer length */=0A=
@@ -575,10 +610,10 @@ int res_nmkquery (res_state statp,=0A=
       statp->res_h_errno =3D NETDB_INTERNAL;=0A=
       return -1;=0A=
     }=0A=
+=0A=
     /* Fill the header */=0A=
-    id =3D statp->id;=0A=
-    PUTSHORT(id, buf);=0A=
-    PUTSHORT(RD, buf);=0A=
+    PUTSHORT(statp->id, buf);=0A=
+    PUTSHORT(RD, buf);=20=0A=
     PUTSHORT(1, buf); /* Number of questions */=0A=
     for (i =3D 0; i < 3; i++)=0A=
       PUTSHORT(0, buf); /* Number of answers */=0A=
@@ -587,7 +622,19 @@ int res_nmkquery (res_state statp,=0A=
     buf +=3D len;=0A=
     PUTSHORT(qtype, buf);=0A=
     PUTSHORT(qclass, buf);=0A=
-    return len + 16; /* packet size */=0A=
+=0A=
+    /* Update id. The current query adds entropy to the next query id */=
=0A=
+    for (id4 =3D qtype, i =3D 0, ptr =3D dnameptr; *ptr; ptr++, i +=3D 3)=
=20=0A=
+      id4 ^=3D *ptr << (i & 0xF);=0A=
+    i =3D 1 + statp->id % 15; /* Between 1 and 16 */=0A=
+    /* id dependent rotation, also brings MSW to LSW */=0A=
+    id4 =3D (id4 << i) ^ (id4 >> (16 - i)) ^ (id4 >> (32 - i));=0A=
+    if ((short) id4)=0A=
+      statp->id ^=3D (short) id4;=0A=
+    else=20=0A=
+      statp->id++; /* Force change */=0A=
+=0A=
+    return len + (HFIXEDSZ + QFIXEDSZ); /* packet size */=0A=
   }=0A=
   else { /* Not implemented */=0A=
     errno =3D ENOSYS;=0A=

------=_NextPart_000_00C4_01C95539.D9F3F330
Content-Type: application/octet-stream;
	name="ChangeLog.minires"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ChangeLog.minires"
Content-length: 371

2008-12-03  Pierre A. Humblet  <Pierre.Humblet@ieee.org>=0A=
=0A=
        * libc/minires.c (open_sock): Set non blocking and close on exec.=
=0A=
	(res_ninit): Set id pseudo-randomly.=0A=
	(res_nsend): Do not set close on exec. Initialize server from id.=0A=
	Flush socket. Tighten rules for answer acceptance.=0A=
	(res_nmkquery): Update id using current data.=0A=
=0A=

------=_NextPart_000_00C4_01C95539.D9F3F330--
