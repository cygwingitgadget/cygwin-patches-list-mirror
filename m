From: Karellen <karellen@boreworms.com>
To: cygwin-patches@cygwin.com
Subject: Patch for syslog - teach it more priorities
Date: Mon, 27 Aug 2001 13:09:00 -0000
Message-id: <3B8AA90A.2070006@boreworms.com>
X-SW-Source: 2001-q3/msg00088.html

Hi there.

Have been using cygwin for a while now, and while doing some development 
under NT4 noticed that all my 'syslog(LOG_DEBUG, "...")' messages were 
getting flagged as 'error's in the NT event log. So had a dig through 
and patched it to work more sanely.

Comments appreciated - especially on whether or not I need to sign forms 
and whatnot to transer copyright over to Redhat for a patch this size. 
Seeing as it just adds to what's there in the style that's already in 
place, I'm hoping I won't have to. :)

Regards,

Karellen


2001-08-27 Karellen (karellen@boreworms.com)

       * syslog.cc (syslog): Teach syslog about syslog priorities other
         than LOG_ERR, LOG_WARNING and LOG_INFO

Index: syslog.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syslog.cc,v
retrieving revision 1.15
diff -u -p -r1.15 syslog.cc
--- syslog.cc   2001/08/04 21:10:52     1.15
+++ syslog.cc   2001/08/27 20:06:21
@@ -256,13 +256,18 @@ syslog (int priority, const char *messag
      WORD eventType;
      switch (LOG_PRI (priority))
        {
+      case LOG_EMERG:
+      case LOG_ALERT:
+      case LOG_CRIT:
        case LOG_ERR:
         eventType = EVENTLOG_ERROR_TYPE;
         break;
        case LOG_WARNING:
         eventType = EVENTLOG_WARNING_TYPE;
         break;
+      case LOG_NOTICE:
        case LOG_INFO:
+      case LOG_DEBUG:
         eventType = EVENTLOG_INFORMATION_TYPE;
         break;
        default:
@@ -306,14 +311,29 @@ syslog (int priority, const char *messag
                as NT has its own priority codes. */
             switch (LOG_PRI (priority))
               {
+             case LOG_EMERG:
+               pass.print ("%s : ", "LOG_EMERG");
+               break;
+             case LOG_ALERT:
+               pass.print ("%s : ", "LOG_ALERT");
+               break;
+             case LOG_CRIT:
+               pass.print ("%s : ", "LOG_CRIT");
+               break;
               case LOG_ERR:
                 pass.print ("%s : ", "LOG_ERR");
                 break;
               case LOG_WARNING:
                 pass.print ("%s : ", "LOG_WARNING");
                 break;
+             case LOG_NOTICE:
+               pass.print ("%s : ", "LOG_NOTICE");
+               break;
               case LOG_INFO:
                 pass.print ("%s : ", "LOG_INFO");
+               break;
+             case LOG_DEBUG:
+               pass.print ("%s : ", "LOG_DEBUG");
                 break;
               default:
                 pass.print ("%s : ", "LOG_ERR");
