From: "Michael A. Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
Cc: <keith_starsmeare@yahoo.co.uk>
Subject: [UNPATCH]Slashes in regtool.exe
Date: Wed, 27 Jun 2001 19:41:00 -0000
Message-id: <003201c0ff7b$929432a0$6464648a@ca.boeing.com>
X-SW-Source: 2001-q2/msg00362.html

The change is unnecessary.  Corrina added the capability in January 2000.  I
have confirmed this behavior with the version of regtool.exe that is part of
1.3.2.  Part of the confusion may be because the leading '\\' is not
required if '\\' separators are being used; it probably ought to be.
Perhaps the examples in usage_msg[] could show both types of separators.

If the first character of the key is '/' (see two lines before patch),
translate() is called to convert '/'s to '\\'s so the user doesn't have to
dirty his hands with '\\'  _unless_ she wants to use a key part that
contains '/'.  If any part of the key contains '/', you don't want
translate() to get its mitts on the string so the first character may not be
'/'.

Other note:

The help screen says "-p" causes '/' to be appended to key names, but it
actually appends '\\'.  I still can't send patches since my assignment isn't
done yet, but you might want to fix this when you reverse the patch.

--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

===================================================================
RCS file: /cvs/uberbaum/winsup/utils/regtool.cc,v
retrieving revision 1.5
retrieving revision 1.6
diff -u -r1.5 -r1.6
--- winsup/utils/regtool.cc 2001/01/10 22:34:02 1.5
+++ winsup/utils/regtool.cc 2001/06/27 17:38:40 1.6
@@ -194,10 +194,13 @@
   int i;
   if (*n == '/')
     translate (n);
-  while (*n == '\\')
+  while ((*n == '\\') || (*n == '/'))
     n++;
-  for (e = n; *e && *e != '\\'; e++);
-  c = *e;
+  for (e = n; *e && *e != '\\' && *e != '/'; e++);
+  if (*e == '/')
+    c = '\\';
+  else
+    c = *e;
   *e = 0;
   for (i = 0; wkprefixes[i].string; i++)
     if (strcmp (wkprefixes[i].string, n) == 0)


