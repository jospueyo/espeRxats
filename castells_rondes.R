source("connection.R")

get_table("diades_castells") %>% 
  filter(!str_detect(castell, "\\dd[45]")) %>% 
  filter(!str_detect(castell, "[pv]d")) %>%
  filter(!str_detect(castell, "aco")) %>% 
  filter(resultat == "d") %>% 
  group_by(castell) %>% 
  mutate(n = n()) %>% 
  filter(n > 1) %>%
  ungroup() %>% 
  filter(ronda %in% c(2,3,4,5)) %>% 
  mutate(ronda = factor(ronda -1)) %>% 
  count(castell, ronda) %>% 
  ggplot(aes(x=castell, y=n, fill=ronda))+
  geom_col(position = position_fill())+
  geom_text(aes(label=n, y=n), position = position_fill(vjust=0.5))+
  scale_y_continuous(labels = scales::percent, expand = expansion(0))

  
# canvia castell i ronda per explorar casos que et generin interès

explora_diada_on <- function(.castell, .ronda, .resultat){
  doi <- get_table("diades_castells") %>% 
    filter(castell == .castell & ronda == .ronda+1 & resultat == .resultat) %>% 
    pull(id_diada)
  
  get_table("diades_castells") %>% 
    filter(id_diada %in% doi) %>% 
    left_join(get_table("diades"), c("id_diada" = "id"))  
}

explora_diada_on("3d7", 3, "d")

