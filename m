Return-Path: <cygwin-patches-return-3320-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13168 invoked by alias); 14 Dec 2002 22:44:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13159 invoked from network); 14 Dec 2002 22:44:25 -0000
Message-Id: <3.0.5.32.20021214173216.007dcaa0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Sat, 14 Dec 2002 14:44:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: {get,set}facl.c (part of ntsec, inheritance and sec_acl)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q4/txt/msg00271.txt.bz2

Corinna,

Please find
1) change getfacl to output a single : for other and mask.
   Note that getfacl --help and the man page already say so.
2) make setfacl accept both the old and new formats for other and mask.
   (this is meant to be a transitory situation).
3) bug fix in main() of setfacl.c

Pierre

2002-12-14  Pierre Humblet <pierre.humblet@ieee.org>

	* setfacl.c (main): Place a single : after other and mask.
	* getfacl.c (getaclentry): Allow both : and :: for other and mask.
	(main): Remove extraneous break.

Index: getfacl.c
===================================================================
RCS file: /cvs/src/src/winsup/utils/getfacl.c,v
retrieving revision 1.8
diff -u -p -r1.8 getfacl.c
--- getfacl.c   24 Nov 2002 16:15:33 -0000      1.8
+++ getfacl.c   14 Dec 2002 22:28:00 -0000
@@ -244,10 +244,10 @@ main (int argc, char **argv)
                printf ("group:%s:", groupname (acls[i].a_id));
              break;
            case CLASS_OBJ:
-             printf ("mask::");
+             printf ("mask:");
              break;
            case OTHER_OBJ:
-             printf ("other::");
+             printf ("other:");
              break;
            }
          printf ("%s\n", permstr (acls[i].a_perm));
Index: setfacl.c
===================================================================
RCS file: /cvs/src/src/winsup/utils/setfacl.c,v
retrieving revision 1.8
diff -u -p -r1.8 setfacl.c
--- setfacl.c   24 Nov 2002 18:07:30 -0000      1.8
+++ setfacl.c   14 Dec 2002 22:13:00 -0000
@@ -165,8 +165,9 @@ getaclentry (action_t action, char *c, a
       if (c2)
         c = c2 + 1;
     }
-  else if (*c++ != ':')
-    return FALSE;
+  /* FIXME: currently allow both :: and : */ 
+  else if (*c == ':')
+    c++;
   if (action == Delete)
     {
       if ((ace->a_type & (CLASS_OBJ | OTHER_OBJ))
@@ -509,7 +510,6 @@ main (int argc, char **argv)
             usage (stderr);
             return 1;
          }
-        break;
         if (! getaclentries (Set, optarg, acls, &aclidx))
           {
             fprintf (stderr, "%s: illegal acl entries\n", prog_name);
