Return-Path: <cygwin-patches-return-3293-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4568 invoked by alias); 10 Dec 2002 05:07:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4557 invoked from network); 10 Dec 2002 05:07:08 -0000
From: "Craig McGeachie" <slapdau@yahoo.com.au>
To: cygwin-patches@cygwin.com
Date: Mon, 09 Dec 2002 21:07:00 -0000
MIME-Version: 1.0
Content-type: Multipart/Mixed; boundary=Message-Boundary-12046
Subject: [patch] netdb.cc to use strtok_r
Reply-to: cygwin-patches@cygwin.com
Message-ID: <3DF62D35.8020.1099672B@localhost>
Priority: normal
X-SW-Source: 2002-q4/txt/msg00244.txt.bz2


--Message-Boundary-12046
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Content-length: 404

2002-12-10 Craig McGeachie <slapdau@yahoo.com.au>

* netdb.cc (parse_alias_list, parse_services_line)
(parse_protocol_line): Change strtok calls to strtok_r.

----------------+-------------------------------------------------
Craig McGeachie | #include <cheesy_tag.h>
+64(21)037-6917 | while (!inebriated) c2h5oh=(++bottle)->contents;
----------------+-------------------------------------------------



--Message-Boundary-12046
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Text from file 'netdb.diff'
Content-length: 3653

Index: cygwin/netdb.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/netdb.cc,v
retrieving revision 1.1
diff -u -p -r1.1 netdb.cc
--- cygwin/netdb.cc	4 Dec 2002 20:44:17 -0000	1.1
+++ cygwin/netdb.cc	10 Dec 2002 04:57:25 -0000
@@ -136,14 +136,14 @@ static const NO_COPY char *SPACE = " \t\
 char** structure terminated by a NULL.
 
 N.B. This routine relies on side effects due to the nature of
-strtok().  strtok() initially takes a char * pointing to the start of
-a line, and then NULL to indicate continued processing.  strtok() does
+strtok_r().  strtok_r() initially takes a char * pointing to the start of
+a line, and then NULL to indicate continued processing.  strtok_r() does
 not provide a mechanism for getting pointer to the unprocessed portion
 of a line.  Alias processing is done part way through a line after
-strtok().  This routine relies on further calls to strtok(), passing
+strtok_r().  This routine relies on further calls to strtok_r(), passing
 NULL as the first parameter, returning alias names from the line. */
 static void
-parse_alias_list (char ***aliases)
+parse_alias_list (char ***aliases, char **lasts)
 {
   struct alias_t
   {
@@ -153,7 +153,7 @@ parse_alias_list (char ***aliases)
   alias_t *alias_list_head = NULL, *alias_list_tail = NULL;
   char *alias;
   int alias_count = 0;
-  alias = strtok (NULL, SPACE);
+  alias = strtok_r (NULL, SPACE, lasts);
 
   while (alias)
     {
@@ -167,7 +167,7 @@ parse_alias_list (char ***aliases)
       new_alias->next = NULL;
       new_alias->alias_name = alias;
       alias_list_tail = new_alias;
-      alias = strtok (NULL, SPACE);
+      alias = strtok_r (NULL, SPACE, lasts);
     }
 
   *aliases = (char**) calloc (alias_count + 1, sizeof (char *));
@@ -201,16 +201,16 @@ parse_services_line (FILE *svc_file, str
   char *line;
   while ((line = get_entire_line (svc_file)))
     {
-      char *name, *port, *protocol;
+      char *name, *port, *protocol, *lasts;
 
       line[strcspn (line, "#")] = '\0'; // truncate at comment marker.
-      name = strtok (line, SPACE);
+      name = strtok_r (line, SPACE, &lasts);
       if (!name)
 	{
 	  free (line);
 	  continue;
 	}
-      port = strtok (NULL, SPACE);
+      port = strtok_r (NULL, SPACE, &lasts);
       protocol = strchr (port, '/');
       *protocol++ = '\0';
       sep->s_name = strdup (name);
@@ -220,7 +220,7 @@ parse_services_line (FILE *svc_file, str
       paranoid_printf ("sep->s_proto strdup %p", sep->s_proto);
       /* parse_alias_list relies on side effects.  Read the comments
 	 for that function.*/
-      parse_alias_list (& sep->s_aliases);
+      parse_alias_list (& sep->s_aliases, &lasts);
       free (line);
       return true;
     }
@@ -322,22 +322,22 @@ parse_protocol_line (FILE *proto_file, s
   char *line;
   while ((line = get_entire_line (proto_file)))
     {
-      char *name, *protocol;
+      char *name, *protocol, *lasts;
 
       line[strcspn (line, "#")] = '\0'; // truncate at comment marker.
-      name = strtok (line, SPACE);
+      name = strtok_r (line, SPACE, &lasts);
       if (!name)
 	{
 	  free (line);
 	  continue;
 	}
-      protocol = strtok (NULL, SPACE);
+      protocol = strtok_r (NULL, SPACE, &lasts);
       pep->p_name = strdup (name);
       paranoid_printf ("pep->p_name strdup %p", pep->p_name);
       pep->p_proto = atoi (protocol);
       /* parse_alias_list relies on side effects.  Read the comments
 	 for that function.*/
-      parse_alias_list (& pep->p_aliases);
+      parse_alias_list (& pep->p_aliases, &lasts);
       free (line);
       return true;
     }

--Message-Boundary-12046--
