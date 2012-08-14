Return-Path: <cygwin-patches-return-7694-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3486 invoked by alias); 14 Aug 2012 20:56:49 -0000
Received: (qmail 3476 invoked by uid 22791); 14 Aug 2012 20:56:48 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,SPF_HELO_PASS,TW_CP,TW_YG
X-Spam-Check-By: sourceware.org
Received: from moutng.kundenserver.de (HELO moutng.kundenserver.de) (212.227.126.187)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 14 Aug 2012 20:56:32 +0000
Received: from [127.0.0.1] (dslb-088-073-028-074.pools.arcor-ip.net [88.73.28.74])	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)	id 0MQ7pz-1T5Ucv2Qa3-004wKA; Tue, 14 Aug 2012 22:56:30 +0200
Message-ID: <502ABB77.2080502@towo.net>
Date: Tue, 14 Aug 2012 20:56:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: /dev/clipboard pasting with small read() buffer
Content-Type: multipart/mixed; boundary="------------020008020604080803060403"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q3/txt/msg00015.txt.bz2

This is a multi-part message in MIME format.
--------------020008020604080803060403
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1



--------------020008020604080803060403
Content-Type: text/plain; charset=windows-1252;
 name="clipboard-small-buffer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="clipboard-small-buffer.patch"
Content-length: 2511

--- sav/fhandler_clipboard.cc	2012-07-08 02:36:47.000000000 +0200
+++ ./fhandler_clipboard.cc	2012-08-14 18:25:14.903255600 +0200
@@ -222,6 +222,7 @@ fhandler_dev_clipboard::read (void *ptr,
   UINT formatlist[2];
   int format;
   LPVOID cb_data;
+  int rach;
 
   if (!OpenClipboard (NULL))
     {
@@ -243,12 +244,18 @@ fhandler_dev_clipboard::read (void *ptr,
       cygcb_t *clipbuf = (cygcb_t *) cb_data;
 
       if (pos < clipbuf->len)
-      	{
+	{
 	  ret = ((len > (clipbuf->len - pos)) ? (clipbuf->len - pos) : len);
 	  memcpy (ptr, clipbuf->data + pos , ret);
 	  pos += ret;
 	}
     }
+  else if ((rach = get_readahead ()) >= 0)
+    {
+      /* Deliver from read-ahead buffer. */
+      * (char *) ptr = rach;
+      ret = 1;
+    }
   else
     {
       wchar_t *buf = (wchar_t *) cb_data;
@@ -256,25 +263,46 @@ fhandler_dev_clipboard::read (void *ptr,
       size_t glen = GlobalSize (hglb) / sizeof (WCHAR) - 1;
       if (pos < glen)
 	{
+	  /* If caller's buffer is too small to hold at least one 
+	     max-size character, redirect algorithm to local 
+	     read-ahead buffer, finally fill class read-ahead buffer 
+	     with result and feed caller from there. */
+	  char * _ptr = (char *) ptr;
+	  size_t _len = len;
+	  char cprabuf [8 + 1];	/* need this length for surrogates */
+	  if (len < 8)
+	    {
+	      _ptr = cprabuf;
+	      _len = 8;
+	    }
+
 	  /* Comparing apples and oranges here, but the below loop could become
 	     extremly slow otherwise.  We rather return a few bytes less than
 	     possible instead of being even more slow than usual... */
-	  if (glen > pos + len)
-	    glen = pos + len;
+	  if (glen > pos + _len)
+	    glen = pos + _len;
 	  /* This loop is necessary because the number of bytes returned by
 	     sys_wcstombs does not indicate the number of wide chars used for
 	     it, so we could potentially drop wide chars. */
 	  while ((ret = sys_wcstombs (NULL, 0, buf + pos, glen - pos))
 		  != (size_t) -1
-		 && ret > len)
+		 && ret > _len)
 	     --glen;
 	  if (ret == (size_t) -1)
 	    ret = 0;
 	  else
 	    {
-	      ret = sys_wcstombs ((char *) ptr, (size_t) -1,
+	      ret = sys_wcstombs ((char *) _ptr, (size_t) -1,
 				  buf + pos, glen - pos);
 	      pos = glen;
+	      /* If using read-ahead buffer, copy to class read-ahead buffer
+	         and deliver first byte. */
+	      if (_ptr == cprabuf)
+		{
+		  puts_readahead (cprabuf, ret);
+		  * (char *) ptr = get_readahead ();
+		  ret = 1;
+		}
 	    }
 	}
     }

--------------020008020604080803060403
Content-Type: text/plain; charset=windows-1252;
 name="clipboard-small-buffer.changelog"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="clipboard-small-buffer.changelog"
Content-length: 214

2012-08-14  Thomas Wolff  <towo@towo.net>

	* fhandler_clipboard.cc (fhandler_dev_clipboard::read): Use 
	read-ahead buffer for reading Windows clipboard if caller's 
	buffer is too small for complete characters.


--------------020008020604080803060403--
