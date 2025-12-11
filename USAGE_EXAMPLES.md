# TiddlyWiki Usage Examples

This document provides practical examples of how to use TiddlyWiki in your Home Assistant setup.

## 📋 Example 1: Home Automation Documentation

### Use Case
Document your Home Assistant setup, automations, and configurations.

### Setup
1. Create a tiddler titled "Home Assistant Setup"
2. Tag it with `documentation` and `home-assistant`
3. Add sections for each area of your home

### Example Structure
```
! Home Assistant Configuration

!! Living Room
* Lights: 3x Philips Hue bulbs
* Motion Sensor: Aqara motion detector
* Automation: Turn on lights when motion detected after sunset

!! Bedroom
* Smart Thermostat: Nest Learning
* Window Sensors: 2x Aqara contact sensors
* Automation: Adjust temperature based on sleep schedule
```

## 🍳 Example 2: Recipe Wiki

### Use Case
Organize your favorite recipes with tags and ratings.

### Setup Template
Create a recipe template tiddler:

```
title: RecipeTemplate
tags: template

! {{!!title}}

''Prep Time:''
''Cook Time:''
''Servings:''
''Rating:'' ⭐⭐⭐⭐⭐

!! Ingredients
*
*
*

!! Instructions
#
#
#

!! Notes
```

### Usage
1. Create new tiddler from template
2. Fill in recipe details
3. Tag with cuisine type (italian, mexican, etc.)
4. Tag with meal type (breakfast, dinner, etc.)
5. Use search and filters to find recipes

## 📝 Example 3: Daily Journal

### Use Case
Keep a daily journal with automatic date tagging.

### Setup
1. Install the "journal" plugin if available
2. Create daily tiddlers with date as title
3. Use tags for mood, activities, etc.

### Example Entry
```
created: 20241207120000000
modified: 20241207120000000
tags: journal mood-happy activity-coding
title: 2024-12-07

! Today's Highlights
* Fixed the 403 error in TiddlyWiki addon
* Added comprehensive documentation
* Weather was beautiful

!! Goals for Tomorrow
- [ ] Test the deployment
- [ ] Review pull requests
- [ ] Plan next feature
```

## 🔧 Example 4: Project Management

### Use Case
Track projects and tasks using TiddlyWiki's task management features.

### Setup
Create project and task tiddlers:

```
! Project: Home Network Upgrade

''Status:'' In Progress
''Start Date:'' 2024-12-01
''Target Date:'' 2024-12-31
''Priority:'' High

!! Tasks
- [x] Research mesh WiFi systems
- [x] Purchase UniFi equipment
- [ ] Install access points
- [ ] Configure network
- [ ] Update documentation

!! Notes
* Budget: $500
* Vendor: Ubiquiti
* Installation date: TBD
```

### Advanced: Kanban View
Use tags to create a kanban board:
- Tag: `status-todo`
- Tag: `status-inprogress`
- Tag: `status-done`

## 📚 Example 5: Knowledge Base

### Use Case
Build a personal knowledge base with linked concepts.

### Structure
```
! Programming Concepts

!! [[Python]]
* Object-oriented language
* Great for automation
* See: [[Python Best Practices]]

!! [[JavaScript]]
* Web development language
* Used in [[Node.js]] and browsers
* See: [[ES6 Features]]

!! [[Docker]]
* Containerization platform
* Used in [[Home Assistant]] addons
* See: [[Docker Commands Reference]]
```

### Benefits
- Bidirectional links between concepts
- Easy to navigate related topics
- Build connections naturally

## 💼 Example 6: Meeting Notes

### Use Case
Document meetings with attendees, agenda, and action items.

### Template
```
title: Meeting - Project Kickoff - 2024-12-07
tags: meeting project-alpha

! Meeting Details
''Date:'' 2024-12-07
''Time:'' 10:00 AM
''Attendees:'' Alice, Bob, Charlie
''Location:'' Conference Room A

!! Agenda
# Project overview
# Timeline discussion
# Resource allocation
# Next steps

!! Discussion Notes
* Project timeline: 3 months
* Budget approved: $50k
* Team size: 5 people

!! Action Items
- [ ] @Alice: Draft project plan by Friday
- [ ] @Bob: Set up development environment
- [ ] @Charlie: Schedule follow-up meeting

!! Next Meeting
''Date:'' 2024-12-14
''Time:'' 10:00 AM
```

## 🎯 Example 7: Goal Tracking

### Use Case
Track personal and professional goals with progress updates.

### Setup
```
! 2024 Goals

!! Health & Fitness
* Goal: Run 5K in under 30 minutes
* Current: 35 minutes
* Progress: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ 30%
* Next milestone: Run 5K in 32 minutes

!! Career
* Goal: Learn Kubernetes
* Progress: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ 50%
* Completed:
** [x] Install Minikube
** [x] Complete basics tutorial
** [x] Deploy first app
* In Progress:
** [ ] Learn about services
** [ ] Study persistent volumes

!! Home Projects
* Goal: Automate all lights
* Progress: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ 80%
* Remaining: Kitchen, garage
```

## 🔗 Example 8: Link Collection

### Use Case
Organize bookmarks and resources by topic.

### Structure
```
! Development Resources

!! Python
* [[Official Python Docs|https://docs.python.org/]]
* [[Real Python Tutorials|https://realpython.com/]]
* [[Python Package Index|https://pypi.org/]]

!! Home Assistant
* [[Official Docs|https://www.home-assistant.io/docs/]]
* [[Community Forum|https://community.home-assistant.io/]]
* [[GitHub Repository|https://github.com/home-assistant/core]]

!! Docker
* [[Docker Hub|https://hub.docker.com/]]
* [[Docker Docs|https://docs.docker.com/]]
* [[Dockerfile Best Practices|https://docs.docker.com/develop/dev-best-practices/]]
```

## 🎨 Tips for Effective Use

### Tagging Strategy
- Use hierarchical tags: `project/home`, `project/work`
- Tag by status: `status-active`, `status-completed`
- Tag by priority: `priority-high`, `priority-low`
- Tag by type: `type-recipe`, `type-note`, `type-reference`

### Search and Filter
- Use TiddlyWiki's search box for quick finds
- Create filtered lists: `<$list filter="[tag[recipe]tag[italian]]"/>`
- Save common filters as tiddlers
- Use the advanced search for complex queries

### Templates
- Create templates for recurring tiddler types
- Use consistent formatting
- Include standard fields
- Save time with reusable structures

### Organization
- Keep tiddlers focused and atomic
- Use links liberally to connect concepts
- Regular cleanup and archiving
- Backup important content

### Performance
- Archive old content periodically
- Optimize images before embedding
- Use external links for large files
- Monitor wiki size in HA System settings

## 🚀 Getting Started Checklist

When you first install the add-on:

- [ ] Create a "Getting Started" tiddler
- [ ] Set up your tagging system
- [ ] Create templates for common tiddler types
- [ ] Add a few sample tiddlers
- [ ] Explore built-in features
- [ ] Install additional plugins if needed
- [ ] Set up authentication if desired
- [ ] Create a backup
- [ ] Customize appearance (themes)
- [ ] Share with family members (if applicable)

## 📖 Additional Resources

- [TiddlyWiki Official Documentation](https://tiddlywiki.com/)
- [TiddlyWiki Community](https://talk.tiddlywiki.org/)
- [Plugin Library](https://tiddlywiki.com/#PluginLibrary)
- [TiddlyWiki on YouTube](https://www.youtube.com/results?search_query=tiddlywiki+tutorial)

---

**Questions?** See the [FAQ section](tiddlywiki/README.md#frequently-asked-questions) or [open an issue](https://github.com/BenSweaterVest/HomeAssistantTiddlyWiki/issues).
